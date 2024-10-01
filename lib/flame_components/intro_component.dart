import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:game/classes/crop.dart';
import 'package:game/classes/crop_states.dart';
import 'package:game/classes/farm.dart';
import 'package:game/classes/seed.dart';
import 'package:game/classes/tile_position.dart';
import 'package:game/flame_components/crop_component.dart';
import 'package:game/flame_components/puma_game.dart';

class IntroComponent extends PositionComponent with HasGameRef<PumaGame> {
  List<Component> previousComponents = [];

  @override
  FutureOr<void> onLoad() {
    planAnimation();
    return super.onLoad();
  }

  void planAnimation() {
    Future.delayed(const Duration(milliseconds: 400), () {
      for (var component in previousComponents) {
        component.removeFromParent();
      }
      if (isRemoved) return;

      final random = Random();

      final recipe = SpriteComponent(
        sprite: Sprite(
          Flame.images.fromCache(game.cookbook!.allRecipes
              .toList()[random.nextInt(game.cookbook!.allRecipes.length)]
              .imagePath),
        ),
        position: Vector2.zero(),
        size: Vector2.all(256),
        anchor: Anchor.center,
      );

      previousComponents.add(recipe);
      add(recipe);

      for (var colIndex = 0; colIndex < Farm.parcelsCount.width; colIndex++) {
        for (var rowIndex = 0;
            rowIndex < Farm.parcelsCount.height;
            rowIndex++) {
          final crop = CropComponent(
            Crop(
                seed: Seed.allSeeds[random.nextInt(Seed.allSeeds.length)],
                position: TilePosition(colIndex, rowIndex),
                plantedOutOfSeason: false)
              ..state = CropState.readyForHarvest,
            freeze: true,
          );
          previousComponents.add(crop);
          game.world.add(crop);
        }
      }

      planAnimation();
    });
  }
}
