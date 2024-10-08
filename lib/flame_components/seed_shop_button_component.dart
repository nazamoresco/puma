import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:game/classes/advice_activatables.dart';
import 'package:game/flame_components/buy_more_seeds_component.dart';
import 'package:game/flame_components/puma_game.dart';
import 'package:game/functions/is_phone_on_flame.dart';

class SeedShopButtonComponent extends SpriteComponent
    with TapCallbacks, HasGameRef<PumaGame>, HasVisibility {
  MoveByEffect? bouncyEffect;

  @override
  FutureOr<void> onLoad() {
    anchor = Anchor.topLeft;
    size = Vector2.all(isPhoneOnFlame(game.camera.viewport.size) ? 64 : 84);
    sprite = Sprite(Flame.images.fromCache("icono_mercado_semillas.png"));
    add(BuyMoreSeedsComponent()..position = Vector2(size.x * .15, size.y * -.2));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    isVisible = game.featureExposure.isSeedShopExposed;

    if (game.dispenser != null) {
      if ((game.dispenser!.seedBags.isEmpty && game.coins > 0) ||
          game.advisorComponent?.currentAdvice?.activable ==
              AdviceActivatables.seedShop) {
        if (!_isBouncing) _startBouncing();
      } else {
        if (_isBouncing) _stopBouncing();
      }
    }

    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (game.overlays.isActive("seed_shop")) {
      game.isPaused = false;
      game.overlays.remove("seed_shop");
    } else {
      game.isPaused = true;
      game.overlays.add("seed_shop");
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
