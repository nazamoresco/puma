import 'dart:async';

import 'package:flame/components.dart';
import 'package:game/flame_components/puma_game.dart';
import 'package:flutter/material.dart';

class HungerBarComponent extends PositionComponent
    with HasGameRef<PumaGame>, HasVisibility {
  final Paint _barPaint;
  final Paint _backgroundPaint;

  double maxValue = 100;
  double currentValue = 0;

  PolygonComponent? totalRectComponent;
  PolygonComponent? filledRectComponent;

  HungerBarComponent({
    Paint? barPaint,
    Paint? backgroundPaint,
  })  : _barPaint = barPaint ?? Paint()
          ..color = Colors.green,
        _backgroundPaint = backgroundPaint ?? Paint()
          ..color = Colors.red,
        super(
          anchor: Anchor.bottomCenter,
          priority: 1500,
        );

  @override
  FutureOr<void> onLoad() {
    isVisible = game.featureExposure.isHungerExposed;
    totalRectComponent = RectangleComponent.fromRect(
      Rect.fromLTWH(0, 0, size.x, size.y),
    )..paint = _backgroundPaint;

    add(totalRectComponent!);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    isVisible = game.featureExposure.isHungerExposed && !game.isOver;

    if (game.hunger != currentValue) {
      currentValue = game.hunger;
      filledRectComponent?.removeFromParent();
      final filledWidth = size.x * ((currentValue - maxValue) / maxValue);
      filledRectComponent = RectangleComponent.fromRect(
        Rect.fromLTWH(0, 0, filledWidth, size.y),
      )..paint = _barPaint;

      add(filledRectComponent!);
    }

    super.update(dt);
  }
}
