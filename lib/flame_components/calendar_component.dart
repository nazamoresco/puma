import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game/flame_components/puma_game.dart';
import 'package:intl/intl.dart';

class CalendarComponent extends TextComponent with HasGameRef<PumaGame> {
  final TextPaint textPaint = TextPaint(
    style: const TextStyle(
      color: Colors.brown,
      fontSize: 24,
      fontFamily: "Crayonara",
    ),
  );

  final DateFormat dateFormat = DateFormat('dd MMM yy');

  @override
  void render(Canvas canvas) {
    textPaint.render(
      canvas,
      dateFormat.format(game.currentDateTime),
      Vector2.zero(),
    );
  }
}
