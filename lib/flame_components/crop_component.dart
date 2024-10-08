import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:game/classes/crop.dart';
import 'package:game/classes/crop_states.dart';
import 'package:game/classes/farm.dart';
import 'package:game/flame_components/plague_component.dart';
import 'package:game/flame_components/puma_game.dart';
import 'package:game/flame_components/ready_to_harvest_icon_component.dart';
import 'package:game/flame_components/tile_component.dart';
import 'package:game/functions/scale_keeping_aspect_ratio.dart';

class CropComponent extends SpriteGroupComponent<CropState>
    with HasGameRef<PumaGame>, TapCallbacks, TileComponent {
  Crop crop;

  /// Neccesary for the animation.
  bool freeze;

  CropComponent(this.crop, {this.freeze = false});

  @override
  onLoad() async {
    super.onLoad();

    priority = 1000;

    final cropSprites = <CropState, Sprite>{};
    for (var cropState in CropState.values) {
      cropSprites[cropState] = Sprite(Flame.images.fromCache(
        cropState.imagePath(seed: crop.seed),
      ));
    }
    sprites = cropSprites;

    // The crop images have 700px of height.
    // The tile images have 512px of height.
    // Adjust the crop given size based on this proportion.
    final oldHeight = size.y;
    size.y *= 700 / 512;

    // We have to align a bit manually.
    position.y -= (size.y - oldHeight) / 2;

    current = crop.state;

    // Display clock for out of season
    if (crop.plantedOutOfSeason) {
      final clockImage = Flame.images.fromCache("relojito.webp");
      add(SpriteComponent(
        sprite: Sprite(clockImage),
        position: Vector2(size.x * .5, size.y * .45),
        size: scaleKeepingAspectRatio(
          aspectRatio: clockImage.size,
          target: Vector2(size.x * .15, -1),
        ),
      ));
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    final result = game.farm!.handleTap(
      crop.position,
      featureExposure: game.featureExposure,
    );
    if (result.type == TapResults.removeCrop) {
      onCropRemoved(result.crop!);
    }

    super.onTapDown(event);
  }

  PlagueComponent? plagueComponent;
  ReadyToHarvestIconComponent? readyToHarvestIconComponent;

  @override
  void update(double dt) {
    if (freeze) return;
    if (game.isOver) return;

    // NM: For some reason some times it gets here after being deleted
    // so we will have to check for null.
    if (game.farm!.crops[tilePosition] == null) {
      return;
    }

    crop = game.farm!.crops[tilePosition]!;
    current = crop.state;

    if (crop.isInfested && plagueComponent == null) {
      plagueComponent = PlagueComponent()
        ..size = size * 0.25
        ..position = Vector2(
          size.x * 0.25,
          size.y * 0.25,
        );

      add(plagueComponent!);
    } else if (!crop.isInfested && plagueComponent != null) {
      remove(plagueComponent!);
      plagueComponent = null;
    }

    if (readyToHarvestIconComponent == null &&
        crop.state == CropState.readyForHarvest) {
      readyToHarvestIconComponent = ReadyToHarvestIconComponent(crop.seed)
        ..size = size * 0.25
        ..anchor = Anchor.center
        ..position = Vector2(
          size.x * 0.5,
          size.y * 0.5,
        );

      add(readyToHarvestIconComponent!);
    } else if (readyToHarvestIconComponent != null &&
        crop.state != CropState.readyForHarvest) {
      remove(readyToHarvestIconComponent!);
      readyToHarvestIconComponent = null;
    }

    super.update(dt);
  }

  void onCropRemoved(Crop crop) {
    FlameAudio.play("seed-planting.mp3", volume: .05);
    FlameAudio.play("item_purchase.wav", volume: .05);
    removeFromParent();
    if (crop.state != CropState.dead) {
      game.dispenser?.harvest(crop.seed);
  }
  }

  @override
  get tilePosition => crop.position;
}
