import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:game/flame_components/puma_game.dart';

class ProducedPlatesCountComponent extends TextComponent
    with HasGameRef<PumaGame> {
  int lastCount = 0;

  @override
  FutureOr<void> onLoad() {
    text = "${game.dietManager?.producedMeals.length} platos";
    textRenderer = TextPaint(
      style: const TextStyle(
        fontFamily: "Crayonara",
        color: Colors.black,
        fontSize: 32,
      ),
    );

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (lastCount != game.dietManager?.producedMeals.length) {
      text = "${game.dietManager!.producedMeals.length} platos";

      add(ScaleEffect.to(
        Vector2.all(1.05),
        EffectController(
          duration: .25,
          reverseDuration: .25,
          curve: Curves.linearToEaseOut,
        ),
      ));

      lastCount = game.dietManager!.producedMeals.length;
    }

    super.update(dt);
  }
}
