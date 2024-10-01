import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:game/classes/seed_bag.dart';
import 'package:game/flame_components/puma_game.dart';
import 'package:game/flame_components/seasons_component.dart';

class SeedBagComponent extends PositionComponent
    with HasGameRef<PumaGame>, TapCallbacks {
  final SeedBag seedBag;

  late final TextComponent countComponent;

  late final CircleComponent borderComponent;

  bool toDestroy = false;

  /// How many seed were we currently displaying.
  /// Used for making an effect when count changes.
  int currentSeedCount = 0;

  SeedBagComponent(this.seedBag);

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    borderComponent = CircleComponent(
      anchor: Anchor.center,
      position: size * .5,
      radius: max(size.x, size.y) * .5,
      paint: Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = max(size.x, size.y) * .05,
    )..opacity = 0;

    add(borderComponent);

    final spriteComponent = SpriteComponent(
      sprite: Sprite(Flame.images.fromCache(seedBag.seed.icon)),
      size: size,
    );

    add(spriteComponent);

    var seasonX = size.x * .95;
    for (var season in seedBag.seed.seasons) {
      final seasonComponent = SeasonsComponent()
        ..size = size * 0.25
        ..current = season
        ..anchor = Anchor.center
        ..position = Vector2(seasonX, size.y * 0.25);

      seasonX = seasonX - size.x * .25;

      add(seasonComponent);
    }

    countComponent = TextComponent(
      text: "${seedBag.count}",
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
          fontFamily: "Crayonara",
        ),
      ),
    )
      ..position = Vector2(size.x * .5, size.y * 1.25)
      ..anchor = Anchor.center;

    add(countComponent);

    // Initialize the current seed count
    currentSeedCount = seedBag.count;
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (game.selectedSeed == seedBag.seed) {
      game.selectedSeed = null;
      borderComponent.opacity = 0;
    } else {
      select();
    }

    super.onTapDown(event);
  }

  void select() {
    game.selectedSeed = seedBag.seed;
    borderComponent.opacity = 1;

    add(ScaleEffect.to(
      Vector2.all(1.1),
      EffectController(
        duration: .5,
        reverseDuration: .5,
        curve: Curves.linearToEaseOut,
      ),
    ));
  }

  /// How the bag moves when the seeds count changes.
  /// We define it here for performance ~ because it won't be
  /// created in theupdate function.
  final bagEffect = ScaleEffect.to(
    Vector2.all(1.05),
    EffectController(
      duration: .25,
      reverseDuration: .25,
      curve: Curves.linearToEaseOut,
    ),
  );

  @override
  void update(double dt) {
    countComponent.text = "${seedBag.count}";

    // Set the opacity based it's selected or not.
    borderComponent.opacity = game.selectedSeed == seedBag.seed ? 1.0 : 0.0;

    if (seedBag.count == 0) {
      removeFromParent();
      return;
    }

    // Do a small jump when we notice a seed was planted.
    if (currentSeedCount != seedBag.count) {
      currentSeedCount = seedBag.count;
      add(bagEffect);
    }

    super.update(dt);
  }
}
