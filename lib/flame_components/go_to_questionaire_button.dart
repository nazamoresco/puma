import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:game/flame_components/puma_game.dart';

class GoToQuestionaireButton extends SpriteComponent with TapCallbacks, HasGameRef<PumaGame> {
  final TextPaint textPaint = TextPaint(
    style: const TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontFamily: "Crayonara",
    ),
  );
  @override
  FutureOr<void> onLoad() {
    anchor = Anchor.topRight;

    // Add background image
    sprite = Sprite(
      Flame.images.fromCache('COCINA_fondo.webp'),
    );
    size = Vector2(300, 50);

    // Add text
    final textComponent = TextComponent(
      text: 'Terminar e ir al cuestionario',
      textRenderer: textPaint,
    );

    textComponent.anchor = Anchor.center;
    textComponent.position = size/2;

    add(textComponent);
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);

    game.goToQuestionaire();
  }
}
