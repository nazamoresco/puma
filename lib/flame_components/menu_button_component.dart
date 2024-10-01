import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'package:game/flame_components/puma_game.dart';

class MenuButtonComponent extends TextComponent
    with TapCallbacks, HasGameRef<PumaGame> {
  final TextPaint textPaint = TextPaint(
    style: const TextStyle(
      color: Colors.black,
      fontSize: 32,
      fontFamily: "Crayonara",
    ),
  );

  @override
  FutureOr<void> onLoad() {
    text = "Menu";
    textRenderer = textPaint;
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.isPaused = true;
    game.overlays.add("menu");
    super.onTapDown(event);
  }
}
