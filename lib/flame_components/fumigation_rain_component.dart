import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:game/flame_components/fumigator_component.dart';
import 'package:game/flame_components/puma_game.dart';

class FumigationRainComponent extends ParticleSystemComponent
    with HasGameRef<PumaGame> {
  final random = Random();

  @override
  FutureOr<void> onLoad() {
    final noise = Tween(begin: -100.0, end: 100.0);
    anchor = Anchor.center;

    particle = Particle.generate(
      count: 100,
      lifespan: FumigatorComponent.animationDuration.inMilliseconds * 0.25,
      generator: (i) {
        return AcceleratedParticle(
          speed: Vector2(
            noise.transform(random.nextDouble()),
            noise.transform(random.nextDouble()),
          ) * -1,
          child: CircleParticle(
            radius: 3,
            paint: Paint()..color = Colors.lightGreen.withOpacity(0.5),
          ),
        );
      },
    );

    return super.onLoad();
  }
}
