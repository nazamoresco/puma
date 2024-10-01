import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'package:game/flame_components/puma_game.dart';

class RestartComponent extends PositionComponent
  with HasGameRef<PumaGame> {
  late final TextComponent textComponent;

  final TextPaint textPaint = TextPaint(
    style: const TextStyle(
      color: Colors.white,
      fontSize: 40,
      fontFamily: "Crayonara",
    ),
  );

  @override
  FutureOr<void> onLoad() {
    textComponent = TextComponent(text: "Presiona para reintentar", textRenderer: textPaint);
    add(textComponent);
    size = textComponent.size;
    return super.onLoad();
  }
}
