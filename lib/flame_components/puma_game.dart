import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:game/classes/cookbook.dart';
import 'package:game/classes/diet_manager.dart';
import 'package:game/classes/farm.dart';
import 'package:game/classes/frog.dart';
import 'package:game/classes/level_configuration.dart';
import 'package:game/classes/player_incremental_feature_exposure.dart';
import 'package:game/classes/recipe.dart';
import 'package:game/classes/seed.dart';
import 'package:game/classes/dispenser.dart';
import 'package:game/classes/time_flow.dart';
import 'package:game/flame_components/advisor_component.dart';
import 'package:game/flame_components/fumigator_component.dart';
import 'package:game/flame_components/game_over_component.dart';
import 'package:game/flame_components/hunger_bar_component.dart';
import 'package:game/flame_components/intro_component.dart';
import 'package:game/flame_components/dimetric_layout.dart';
import 'package:game/flame_components/puma_world.dart';
import 'package:game/flame_components/seasons_component.dart';
import 'package:game/flame_components/seed_dispenser_component.dart';
import 'package:game/flame_components/tile_component.dart';
import 'package:game/flame_components/top_left_menu_component.dart';
import 'package:game/flame_components/top_right_menu_component.dart';

class PumaGame extends FlameGame {
  /// Slowly increments the exposure to new features to the player
  /// We want to keep it between restarts, because the player was already exposed.
  late PlayerIncrementalFeatureExposure featureExposure;

  /// The date time in game
  DateTime currentDateTime = DateTime.now();

  /// How the time flows in the game, works with 'currentDateTime'
  Timer? _timeFlow;

  /// The advisor has its own timer so he can analyze the situation when the
  /// game is paused.
  Timer? _advisorTimer;

  /// Farm
  Farm? farm;

  /// The 'cookbook' stores all the recipes
  Cookbook? cookbook;

  /// The 'diet manager' stores all the meals to prepare
  DietManager? dietManager;

  /// The 'seed dispenser' stores all the seeds from the player
  Dispenser? dispenser;

  /// Which seed the player has selected
  Seed? selectedSeed;

  /// How many plates the player has to produce to win the game
  static const numberOfPlatesToProduce = 100;

  /// Wheter the game is over or not.
  bool isOver = false;

  /// Whether the game is paused or not.
  bool _isPaused = false;

  /// Whether the backgrond music is playing or not.
  double _musicVolume = 0.025;

  int coins = 5;

  double hunger = 0;

  @override
  final PumaWorld world = PumaWorld();

  @override
  late CameraComponent camera;

  SeedDispenserComponent? seedDispenserComponent;

  AdvisorComponent? advisorComponent;

  SeasonsComponent? seasonsComponent;

  /// In the ui, the top left menu component
  TopLeftMenuComponent? topLeftMenuComponent;

  /// In the ui, the top right menu component
  TopRightMenuComponent? topRightMenuComponent;

  //Comment?
  GameOverComponent? gameOverComponent;

  /// To store the intro animation
  IntroComponent? introComponent;

  /// What seeds can the player purchase.
  late Set<Seed> purchasableSeeds;

  // The guest in the kitchen
  late Frog frog;

  /// Whether the game is paused or not.
  get isPaused => _isPaused;

  final void Function() goToQuestionaire;

  /// Sets the internal variable '_isPaused' and stops or restarts the time flow.
  set isPaused(boolean) {
    _isPaused = boolean;
    if (_isPaused) {
      _timeFlow?.pause();
    } else {
      _timeFlow?.resume();
    }
  }

  /// Whether the game is paused or not.
  double get musicVolume => _musicVolume;

  /// Sets the internal variable '_isPaused' and stops or restarts the time flow.
  set musicVolume(number) {
    _musicVolume = number;
    FlameAudio.bgm.audioPlayer.setVolume(_musicVolume);
  }

  Vector2 get initialCameraPosition =>
      DimetricLayout(
        tilePosition: Farm.centerPosition,
        size: TileComponent.tileSize(this),
        scale: Vector2.all(1),
      ).renderPosition -
      Vector2(
        0,
        TileComponent.tileSize(this).y,
      );

  /// Last time that the player was asked for meal choose
  DateTime? lastMealChosenAt;

  @override
  Color backgroundColor() => Colors.transparent;

  final EdgeInsets safeAreaPadding;

  LevelConfiguration levelConfiguration;

  /// Wheter the images and audios files were already
  /// loaded to cache. To avoid loading them twice.
  final bool areAssetsCached;

  /// This function has to be exectuted after
  /// assets were cached. To avoid loading them twice.
  final void Function() onAssetsCached;

  final Map<Recipe, int> producedPlates = {};

  /// Audio pools
  late final AudioPool seedPlanting;
  late final AudioPool touch;

  PumaGame({
    required this.safeAreaPadding,
    required this.levelConfiguration,
    required this.areAssetsCached,
    required this.onAssetsCached,
    required this.goToQuestionaire,
  }) {
    featureExposure = levelConfiguration.featureExposure;
    camera = CameraComponent(world: world)..viewfinder.anchor = Anchor.center;
  }

  @override
  onLoad() async {
    FlameAudio.bgm.initialize();

    // Load assets if they weren't cached before
    if (!areAssetsCached) {
      await Future.wait([
        Flame.images.loadAllImages(),
        FlameAudio.audioCache.loadAll([
          "item_purchase.wav",
          "level_win.mp3",
          "recipe_sold.wav",
          "recipe_unlock.wav",
          "sad-noise.wav",
          "seed-planting.mp3",
          "touch.wav",
          "cooking.mp3",
          "espantapajaro.mp3",
          "mistake.mp3",
        ]),
      ]).then((_) => onAssetsCached());
    }

    // Create pools for audios that need to be executed fast
    seedPlanting =
        await FlameAudio.createPool("seed-planting.mp3", maxPlayers: 9);
    touch = await FlameAudio.createPool("touch.wav", maxPlayers: 9);
    // FlameAudio.createPool("sad-noise.mp3", maxPlayers: 9);

    // Initialize game elements: seed dispenser, farm, cookbook and diet manager
    farm = Farm();
    dispenser = Dispenser();
    cookbook = Cookbook()
      ..unlockableRecipes = levelConfiguration.unlockableRecipes;
    dietManager = DietManager();

    // Create camera for our world;
    addAll([camera, world]);

    // Position camera
    camera.moveTo(initialCameraPosition);

    // Add top left menu component
    topLeftMenuComponent = TopLeftMenuComponent()
      ..position = Vector2(
        16 + safeAreaPadding.left,
        40 + safeAreaPadding.top,
      );

    camera.viewport.add(topLeftMenuComponent!);

    // Include top right menu component
    topRightMenuComponent = TopRightMenuComponent()
      ..position = Vector2(
        camera.viewport.size.x - 16,
        16 + safeAreaPadding.top,
      );

    camera.viewport.add(topRightMenuComponent!);

    purchasableSeeds = levelConfiguration.seeds;

    // Add seed dispenser component
    seedDispenserComponent = SeedDispenserComponent()
      ..position = Vector2(
        camera.viewport.size.x / 2,
        camera.viewport.size.y * .8,
      )
      ..anchor = Anchor.center;

    camera.viewport.add(seedDispenserComponent!);

    // Add FPS text component
    camera.viewport.add(
      FpsTextComponent()
        ..anchor = Anchor.bottomRight
        ..position = Vector2(
          camera.viewport.size.x,
          camera.viewport.size.y,
        ),
    );

    // Add advisor component
    advisorComponent = AdvisorComponent(levelConfiguration.advices)
      ..position = Vector2(
        0 + safeAreaPadding.left,
        camera.viewport.size.y,
      );

    camera.viewport.add(advisorComponent!);

    camera.viewport.add(
      HungerBarComponent()
        ..size = Vector2(camera.viewport.size.x * .5, 15)
        ..position = Vector2(
          camera.viewport.size.x * .5,
          16 + safeAreaPadding.top,
        )
        ..anchor = Anchor.center,
    );

    // Initialize timer
    _timeFlow = Timer(
      const Duration(milliseconds: 500).inMilliseconds / 1000,
      onTick: () {
        currentDateTime = currentDateTime.add(const Duration(days: 1));
        final result = farm!.tick(currentDateTime, featureExposure);

        if (result.isFumigationScheduled) {
          camera.viewport.add(FumigatorComponent());
          Future.delayed(FumigatorComponent.animationDuration).then(
            (_) => farm?.fumigate(),
          );
        }

        seasonsComponent!.current = currentDateTime.season;

        if (featureExposure.isHungerExposed) {
          hunger += .5;
        }
      },
      repeat: true,
    );

    // We need a timer for advices as well.
    _advisorTimer = Timer(
      const Duration(milliseconds: 500).inMilliseconds / 1000,
      onTick: () {
        advisorComponent?.analyze();
      },
      repeat: true,
    )..start();

    frog = Frog()..yap();
    ;
  }

  /// Takes care of all the needs for restarting the game
  restartGame() {
    FlameAudio.bgm.play("tango.mp3", volume: musicVolume);

    coins = 5;

    featureExposure = levelConfiguration.featureExposure;

    // Remove game over component
    gameOverComponent?.removeFromParent();
    gameOverComponent = null;

    // Initialize game elements: seed dispenser, farm, cookbook and diet manager
    farm = Farm();
    dispenser = Dispenser();
    cookbook = Cookbook()
      ..unlockableRecipes = levelConfiguration.unlockableRecipes;
    dietManager = DietManager();

    // Add top left menu component
    topLeftMenuComponent = TopLeftMenuComponent()
      ..position = Vector2(
        16 + safeAreaPadding.left,
        40 + safeAreaPadding.top,
      );

    camera.viewport.add(topLeftMenuComponent!);

    // Include top right menu component
    topRightMenuComponent = TopRightMenuComponent()
      ..position = Vector2(
        camera.viewport.size.x - 16,
        16 + safeAreaPadding.top,
      );
    camera.viewport.add(topRightMenuComponent!);

    // Add seed dispenser component
    seedDispenserComponent = SeedDispenserComponent()
      ..position = Vector2(
        camera.viewport.size.x / 2,
        camera.viewport.size.y * .8,
      )
      ..anchor = Anchor.center;

    camera.viewport.add(seedDispenserComponent!);

    // Add FPS text component
    camera.viewport.add(
      FpsTextComponent()
        ..anchor = Anchor.bottomRight
        ..position = Vector2(
          camera.viewport.size.x,
          camera.viewport.size.y,
        ),
    );

    // Add advisor component
    advisorComponent!.restart(levelConfiguration.advices);

    /// Re set what seeds can be purchased.
    purchasableSeeds = levelConfiguration.seeds;

    // Restart hunger
    hunger = 0;

    // Restart world
    world.restart();

    // Initialize timer
    _timeFlow!.start();
    isOver = false;

    camera.moveTo(initialCameraPosition);
    frog = Frog()..yap();
  }

  /// Takes care of all the side effects of finishing the game.
  finishGame() {
    FlameAudio.bgm.stop();
    isOver = true;
    advisorComponent!.shutDown();

    // Remove all components
    topLeftMenuComponent!.removeFromParent();
    topRightMenuComponent!.removeFromParent();
    seedDispenserComponent!.removeFromParent();
    seasonsComponent!.removeFromParent();
    introComponent?.removeFromParent();

    // Nullify all components
    topLeftMenuComponent = null;
    topRightMenuComponent = null;
    seedDispenserComponent = null;
    seasonsComponent = null;
    introComponent = null;

    // Nullify all game component
    farm = null;
    cookbook = null;
    selectedSeed = null;
    dietManager = null;

    // Stop time
    _timeFlow!.stop();

    // Close all overlays
    overlays.removeAll(overlays.activeOverlays.toList());
  }

  @override
  void onDispose() {
    FlameAudio.bgm.stop();
    super.onDispose();
  }

  @override
  void update(double dt) {
    if (isOver) {
      super.update(dt);
      return;
    }

    _timeFlow!.update(dt);
    _advisorTimer!.update(dt);

    if (farm!.usability.isDestroyed && !isOver) {
      gameOverComponent = GameOverComponent();

      world.add(gameOverComponent!);

      camera.viewfinder.add(
        MoveByEffect(
          Vector2(0, gameOverComponent!.size.y * .75),
          EffectController(duration: 2.5),
        ),
      );

      super.update(dt);
      finishGame();
      return;
    } else if (!isOver && levelConfiguration.winingCondition.isGameWon(this)) {
      finishGame();
      overlays.add("victory");

      super.update(dt);
      return;
    }

    super.update(dt);
  }

  nextLevel() {
    if (levelConfiguration == LevelConfiguration.level1) {
      levelConfiguration = LevelConfiguration.level2;
      restartGame();
    } else if (levelConfiguration == LevelConfiguration.level2) {
      levelConfiguration = LevelConfiguration.level3;
      restartGame();
    } else if (levelConfiguration == LevelConfiguration.level3) {
      levelConfiguration = LevelConfiguration.level4;
      restartGame();
    } else {
      return;
    }
  }
}
