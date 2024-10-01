import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:game/classes/advice.dart';
import 'package:game/flame_components/advisor_component.dart';
import 'package:game/flame_components/puma_game.dart';

class AdviceComponent extends TextBoxComponent
    with HasGameRef<PumaGame>, ParentIsA<AdvisorComponent>, TapCallbacks {
  final Advice advice;
  final double maxWidth;

  late final TextComponent closingText;

  static get cornerSize => Vector2(25, 25);

  AdviceComponent(this.advice, {required this.maxWidth})
      : super(
          text: advice.text,
          textRenderer: TextPaint(
            style: const TextStyle(
              fontFamily: "Crayonara",
              color: Colors.black,
              fontSize: 24,
            ),
          ),
          boxConfig: TextBoxConfig(
            maxWidth: maxWidth,
            margins: EdgeInsets.symmetric(
              horizontal: cornerSize.x,
              vertical: cornerSize.y,
            ),
            growingBox: true,
          ),
        );

  @override
  Future<void> onLoad() {
    add(
      SpriteComponent(
        sprite: Sprite(
          Flame.images.fromCache("pie_de_dialogo_${_getInt(5)}.webp"),
        ),
      )
        ..size = cornerSize
        ..position = Vector2(cornerSize.x / 2, size.y - cornerSize.y * 0.5),
    );

    closingText = TextComponent(
      text: "",
      textRenderer: TextPaint(
        style: const TextStyle(
          fontFamily: "Crayonara",
          color: Colors.black,
          fontSize: 14,
        ),
      ),
    );

    add(closingText);

    return super.onLoad();
  }

  final bgPaint = Paint()..color = Colors.white.withOpacity(0.9);

  @override
  void render(Canvas canvas) {
    Rect rect = Rect.fromLTWH(
      (0.0 + cornerSize.x * 0.5),
      (0.0 + cornerSize.y * 0.5),
      width - cornerSize.x,
      (height - cornerSize.y) + 10,
    );

    if(closingText.text == "") {
      closingText.text = "Tocá para continuar...";
      closingText.position.x = (width - cornerSize.x) - 8;
      closingText.position.y = (height - cornerSize.y) + 8;
      closingText.anchor = Anchor.centerRight;
    }

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(25.0)),
      bgPaint,
    );
    super.render(canvas);
  }

  _getInt(int max) => Random().nextInt(max) + 1;

  @override
  void onTapDown(TapDownEvent event) {
    parent.hideAdvice();
  }
}
