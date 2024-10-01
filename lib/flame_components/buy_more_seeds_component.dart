import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game/flame_components/puma_game.dart';

class BuyMoreSeedsComponent extends TextComponent
    with HasVisibility, HasGameRef<PumaGame> {
  @override
  FutureOr<void> onLoad() {
    isVisible = false;
    text = "Compra semillas!";
    textRenderer = TextPaint(
      style: const TextStyle(
        fontFamily: "Crayonara",
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 14,
      ),
    );

    angle = 0.2;

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (!isVisible &&
        game.dispenser != null &&
        game.dispenser!.seedBags.isEmpty && game.coins > 0) {
      isVisible = true;
    } else if (isVisible &&
        game.dispenser != null &&
        game.dispenser!.seedBags.isNotEmpty || game.coins == 0) {
      isVisible = false;
    }

    super.update(dt);
  }
}
