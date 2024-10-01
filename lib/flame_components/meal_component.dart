import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:game/classes/meal.dart';

class MealComponent extends SpriteComponent {
  final Meal meal;

  late TextComponent countComponent;

  bool toDestroy = false;

  MealComponent(this.meal);

  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(Flame.images.fromCache(meal.recipe.imagePath));

    // Add count of meals
    countComponent = TextComponent(
      text: "${meal.count}x",
      textRenderer: TextPaint(
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
    )
      ..position = size * 0.8
      ..anchor = Anchor.center;

    add(countComponent);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    countComponent.text = "${meal.count}x";

    super.update(dt);
  }
}
