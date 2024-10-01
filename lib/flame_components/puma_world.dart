import 'dart:async';

import 'package:flame/components.dart';
import 'package:game/classes/farm.dart';
import 'package:game/classes/tile_position.dart';
import 'package:game/flame_components/background_sprite.dart';
import 'package:game/flame_components/parcel_component.dart';
import 'package:game/flame_components/puma_game.dart';

class PumaWorld extends World with HasGameRef<PumaGame> {
  late final BackgroundSprite backgroundComponent;

  Vector2 get size => backgroundComponent.size;

  void restart() {
    removeAll(children);
    add(backgroundComponent);
    for (var colIndex = 0; colIndex < Farm.parcelsCount.width; colIndex++) {
      for (var rowIndex = 0; rowIndex < Farm.parcelsCount.height; rowIndex++) {
        add(ParcelComponent(tilePosition: TilePosition(colIndex, rowIndex)));
      }
    }
  }

  @override
  FutureOr<void> onLoad() {
    backgroundComponent = BackgroundSprite();
    add(backgroundComponent);

    for (var colIndex = 0; colIndex < Farm.parcelsCount.width; colIndex++) {
      for (var rowIndex = 0; rowIndex < Farm.parcelsCount.height; rowIndex++) {
        add(ParcelComponent(tilePosition: TilePosition(colIndex, rowIndex)));
      }
    }

    return super.onLoad();
  }
}
