import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:game/classes/advice.dart';
import 'package:game/classes/advice_activatables.dart';
import 'package:game/classes/crop_states.dart';
import 'package:game/classes/player_incremental_feature_exposure.dart';
import 'package:game/classes/recipe.dart';
import 'package:game/classes/seed.dart';
import 'package:game/classes/winning_condition.dart';
import 'package:game/flame_components/intro_component.dart';

class LevelConfiguration {
  final PlayerIncrementalFeatureExposure featureExposure;
  final List<Advice> advices;
  final Set<Recipe> unlockableRecipes;
  final Set<Seed> seeds;
  final WiningCondition winingCondition;

  const LevelConfiguration({
    required this.featureExposure,
    required this.advices,
    required this.seeds,
    required this.unlockableRecipes,
    required this.winingCondition,
  });

  static LevelConfiguration level1 = LevelConfiguration(
    featureExposure: PlayerIncrementalFeatureExposure(),
    winingCondition: WiningCondition(
      label: (game) => "Llega a 50 monedas!",
      victoryComment: (game) =>
          "Felicidades! Llegaste a 50 monedas! Continua al siguiente nivel.",
      isGameWon: (game) =>
          game.coins >= 50 && (game.cookbook?.lockedRecipes.isEmpty ?? false),
    ),
    seeds: {
      Seed.tomato,
      Seed.lettuce,
      Seed.onion,
      Seed.potato,
      Seed.carrot,
    },
    unlockableRecipes: {
      Recipe.gazpacho,
      Recipe.classicSalad,
      Recipe.tortilla,
      Recipe.potatoCarrotCasserole,
    },
    advices: [
      Advice(
        text:
            "Lo que comemos determina lo que cultivamos\ny por lo tanto, como se ven las huertas.",
        beforeDisplaying: (game) {
          game.introComponent = IntroComponent()
            ..position = Vector2(game.size.x / 2, game.size.y * .1)
            ..anchor = Anchor.center;
          game.add(game.introComponent!);
          return true;
        },
        whenComplete: (game) {
          game.introComponent!.removeFromParent();
          game.introComponent = null;
          FlameAudio.bgm.play("tango.mp3", volume: game.musicVolume);
          return true;
        },
      ),
      Advice(
        text:
            "Soy tu fiel espantapajaros y esta es tu huerta. Toca sobre mi para saber mas!",
      ),
      Advice(
        text:
            "Tu objetivo es hacer 50 monedas y desbloquear todas las recetas!",
      ),
      Advice(
        text: "En este nivel te enseñare como hacerlo!",
      ),
      Advice(
        text: "Toca una parcela para sembrar un semilla",
        wasFollowed: (game) => game.farm!.crops.values.isNotEmpty,
      ),
      Advice(
        text: "Vaya! Esa parcela esta lista, toca para cosechar",
        isGoodTiming: (game) =>
            game.farm?.crops.values.any(
              (crop) => crop.state == CropState.readyForHarvest,
            ) ??
            false || (game.farm?.history.historicalCropCount ?? 0) > 0,
        wasFollowed: (game) =>
            (game.farm?.history.historicalCropCount ?? 0) > 0,
      ),
      Advice(
        text: "Abre el mercado de semillas para comprar mas semillas",
        activable: AdviceActivatables.seedShop,
        isGoodTiming: (game) => ((game.dispenser?.seedBags.isEmpty ?? false) &&
            ((game.farm?.history.historicalCropCount ?? 0) > 1)),
        wasFollowed: (game) =>
            game.overlays.isActive("seed_shop") || game.coins == 0,
      ),
      Advice(
        text: "Abre la cocina para descubrir recetas",
        activable: AdviceActivatables.kitchen,
        isGoodTiming: (game) =>
            game.dispenser != null &&
            (game.dispenser!.harvests.isNotEmpty) &&
            (game.dispenser!.harvests.length >= 3 ||
                game.dispenser!.harvests.first.count > 3),
        wasFollowed: (game) => game.overlays.isActive("kitchen"),
      ),
    ],
  );

  static LevelConfiguration level2 = LevelConfiguration(
    featureExposure: PlayerIncrementalFeatureExposure()
      ..isSeedShopExposed = true
      ..isKitchenExposed = true,
    winingCondition: WiningCondition(
      label: (game) => "Llega a 50 monedas!",
      victoryComment: (game) =>
          "Felicidades! Ya dominas la rotacion de cultivos! Continua al siguiente nivel!",
      isGameWon: (game) =>
          game.coins >= 50 && (game.cookbook?.lockedRecipes.isEmpty ?? false),
    ),
    seeds: {
      Seed.tomato,
      Seed.lettuce,
      Seed.onion,
      Seed.potato,
      Seed.pumpkin,
      Seed.broccoli,
      Seed.carrot,
    },
    unlockableRecipes: {
      Recipe.gazpacho,
      Recipe.classicSalad,
      Recipe.tortilla,
      Recipe.pumpkinRecipe,
      Recipe.potatoCarrotCasserole,
    },
    advices: [
      Advice(
        text: "Rota las semillas que siembras sobre una parcela!",
        whenComplete: (game) =>
            game.featureExposure.areCropRotationsExposed = true,
      ),
    ],
  );

  static LevelConfiguration level3 = LevelConfiguration(
    featureExposure: PlayerIncrementalFeatureExposure()
      ..isSeedShopExposed = true
      ..isKitchenExposed = true
      ..areCropRotationsExposed = true,
    winingCondition: WiningCondition(
      label: (game) => "Llega a 50 monedas!",
      victoryComment: (game) =>
          "Felicidades! Ya dominas el manejo de plagas! Continua al siguiente nivel!",
      isGameWon: (game) =>
          game.coins >= 50 && (game.cookbook?.lockedRecipes.isEmpty ?? false),
    ),
    seeds: {
      Seed.tomato,
      Seed.lettuce,
      Seed.onion,
      Seed.pumpkin,
      Seed.broccoli,
      Seed.carrot,
      Seed.cucumber,
      Seed.potato,
    },
    unlockableRecipes: {
      Recipe.gazpacho,
      Recipe.classicSalad,
      Recipe.pumpkinRecipe,
      Recipe.broccoliCarrot,
      Recipe.tortilla,
      Recipe.potatoCarrotCasserole,
    },
    advices: [
      Advice(
        text: "Muchas parcelas de un mismo cultivo trae plagas",
        whenComplete: (game) => game.featureExposure.arePlaguesExposed = true,
      ),
    ],
  );

  static LevelConfiguration level4 = LevelConfiguration(
    featureExposure: PlayerIncrementalFeatureExposure()
      ..isSeedShopExposed = true
      ..isKitchenExposed = true
      ..areCropRotationsExposed = true
      ..arePlaguesExposed = true,
    winingCondition: WiningCondition(
      label: (game) => "Llega a 50 monedas!",
      victoryComment: (game) =>
          "Felicidades! Dominaste la plantacion en temporada y has superado PUMA! Vuelve al menu principal.",
      isGameWon: (game) =>
          game.coins >= 50 && (game.cookbook?.lockedRecipes.isEmpty ?? false),
    ),
    seeds: {
      Seed.tomato,
      Seed.lettuce,
      Seed.onion,
      Seed.pumpkin,
      Seed.broccoli,
      Seed.carrot,
      Seed.artichoke,
      Seed.quinoa,
      Seed.cucumber,
      Seed.potato,
    },
    unlockableRecipes: {
      Recipe.gazpacho,
      Recipe.classicSalad,
      Recipe.pumpkinRecipe,
      Recipe.broccoliCarrot,
      Recipe.artichokeWithQuinoa,
      Recipe.tortilla,
      Recipe.potatoCarrotCasserole,
      Recipe.quinoaBroccoliSalad,
    },
    advices: [
      Advice(
        text:
            "Intenta sembrar en la temporada correcta para que el cultivo crezca más rápido!",
        whenComplete: (game) => game.featureExposure.areSeasonsExposed = true,
      ),
    ],
  );
}
