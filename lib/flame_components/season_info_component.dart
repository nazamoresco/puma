import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game/classes/time_flow.dart';
import 'package:game/flame_components/puma_game.dart';
import 'package:game/flame_components/seasons_component.dart';

class SeasonInfoComponent extends PositionComponent
    with HasGameRef<PumaGame>, HasVisibility {
  late final TextComponent seasonCompletionPercentageComponent;

  @override
  FutureOr<void> onLoad() {
    isVisible = game.featureExposure.areSeasonsExposed;

    final currentPosition = Vector2(0, 0);

    game.seasonsComponent = SeasonsComponent(game.currentDateTime.season)
      ..size = Vector2.all(84)
      ..position = currentPosition
      ..anchor = Anchor.centerLeft;

    add(game.seasonsComponent!);

    seasonCompletionPercentageComponent = TextComponent(
      text: "Cargando...",
      textRenderer: TextPaint(
        style: const TextStyle(
          fontFamily: "Crayonara",
          color: Colors.black,
          fontSize: 24,
        ),
      ),
      anchor: Anchor.centerLeft,
      position: currentPosition + Vector2(game.seasonsComponent!.size.x + 8, 0),
    );

    add(seasonCompletionPercentageComponent);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    isVisible = game.featureExposure.areSeasonsExposed;
    seasonCompletionPercentageComponent.text =
        "${game.currentDateTime.seasonCompletionPercentage.truncate()}%";

    if (game.seasonsComponent?.size.y != null) {
      size.y = game.seasonsComponent!.size.y;
    }

    super.update(dt);
  }
}
