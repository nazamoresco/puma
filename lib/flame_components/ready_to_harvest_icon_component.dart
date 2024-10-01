import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:game/classes/seed.dart';
import 'package:game/functions/scale_keeping_aspect_ratio.dart';

class ReadyToHarvestIconComponent extends SpriteComponent {
  final Seed seed;

  ReadyToHarvestIconComponent(this.seed);

  @override
  FutureOr<void> onLoad() {
    final image = Flame.images.fromCache(seed.icon);
    size = scaleKeepingAspectRatio(
      aspectRatio: image.size,
      target: Vector2(-1, size.y),
    );
    sprite = Sprite(image);

    add(
      MoveByEffect(
        Vector2(0, -15),
        EffectController(
          infinite: true,
          duration: 1,
          curve: Curves.fastEaseInToSlowEaseOut,
          reverseDuration: .5,
          reverseCurve: Curves.fastEaseInToSlowEaseOut,
        ),
      ),
    );
    return super.onLoad();
  }
}
