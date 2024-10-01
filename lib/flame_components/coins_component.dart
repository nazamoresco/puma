import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:game/flame_components/puma_game.dart';
import 'package:game/flame_components/row_component.dart';

class CoinsComponent extends RowComponent with HasGameRef<PumaGame> {
  late final TextComponent coinsCount;
  int? coins;

  @override
  FutureOr<void> onLoad() {
    gap = 1;

    coinsCount = TextComponent(
      text: "...",
      position: Vector2(48, 24),
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.black,
          fontSize: 32,
          fontFamily: "Crayonara",
        ),
      ),
    );

    add(coinsCount);

    final coinsIcon = SpriteComponent(
      sprite: Sprite(Flame.images.fromCache("icono_moneda.webp")),
      size: Vector2.all(40),
    );

    add(coinsIcon);

    // TODO: implement onLoad
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (coins != game.coins) {
      coinsCount.text = "${game.coins.toString()}/50";
      coins = game.coins;
      add(ScaleEffect.to(
        Vector2.all(1.05),
        EffectController(
          duration: .25,
          reverseDuration: .25,
          curve: Curves.linearToEaseOut,
        ),
      ));
    }
    super.update(dt);
  }
}
