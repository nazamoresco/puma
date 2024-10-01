import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game/flame_components/puma_game.dart';

class MonocultivePercentageComponent extends PositionComponent
    with HasGameRef<PumaGame>, HasVisibility {
  final TextPaint textPaint = TextPaint(
    style: const TextStyle(
      color: Colors.black,
      fontSize: 30,
      fontFamily: "Crayonara",
    ),
  );

  late TextComponent percentageComponent;

  String get percentageString {
    final concentrations = game.farm!.calculateCropsConcentrations().values;

    return "${concentrations.isEmpty ? 0 : (concentrations.max * 100).toInt()}%";
  }

  @override
  FutureOr<void> onLoad() {
    isVisible = game.featureExposure.arePlaguesExposed;

    final component = TextComponent(
      text: "monocultivo",
      textRenderer: textPaint,
    );

    add(component);

    size = component.size;

    percentageComponent = TextComponent(
      text: percentageString,
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

    add(percentageComponent);

    size.y += percentageComponent.size.y;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    isVisible = game.featureExposure.arePlaguesExposed;
    percentageComponent.text = percentageString;

    super.update(dt);
  }
}
