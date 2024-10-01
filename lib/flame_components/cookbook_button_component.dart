import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/widgets.dart';
import 'package:game/classes/advice_activatables.dart';
import 'package:game/flame_components/puma_game.dart';

class CookbookButtonComponent extends SpriteComponent
    with TapCallbacks, HasGameRef<PumaGame>, HasVisibility {
  MoveByEffect? bouncyEffect;

  @override
  FutureOr<void> onLoad() {
    size = Vector2.all(84);
    sprite = Sprite(Flame.images.fromCache("icono_recetas_1.webp"));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    isVisible = game.featureExposure.isKitchenExposed;

        if (game.advisorComponent?.currentAdvice?.activable ==
        AdviceActivatables.kitchen) {
      if (!_isBouncing) _startBouncing();
    } else {
      if (_isBouncing) _stopBouncing();
    }

    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (game.overlays.isActive("kitchen")) {
      game.isPaused = false;
      game.overlays.remove("kitchen");
    } else {
      game.isPaused = true;
      game.overlays.add("kitchen");
    }

    super.onTapDown(event);
  }

  bool get _isBouncing => bouncyEffect != null;

  void _startBouncing() {
    bouncyEffect = MoveByEffect(
      Vector2(0, -5),
      EffectController(
        infinite: true,
        duration: .5,
        curve: Curves.fastEaseInToSlowEaseOut,
        reverseDuration: .5,
        reverseCurve: Curves.fastEaseInToSlowEaseOut,
      ),
    );

    add(bouncyEffect!);
  }

  void _stopBouncing() {
    remove(bouncyEffect!);
    bouncyEffect = null;
  }
}
