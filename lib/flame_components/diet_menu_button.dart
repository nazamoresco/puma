import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';

class DietMenuButton extends HudButtonComponent with HasGameRef {
  @override
  onLoad() {
    button = SpriteComponent(
      sprite: Sprite(Flame.images.fromCache("icono_recetas_1.webp")),
      size: size,
    );

    // onPressed = () {
    //   game.overlays.add(OverlaysIdentifiers.dietMenu.toString());
    // };

    super.onLoad();
  }
}
