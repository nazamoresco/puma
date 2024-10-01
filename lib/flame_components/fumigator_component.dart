import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:game/flame_components/fumigation_rain_component.dart';
import 'package:game/flame_components/puma_game.dart';

class FumigatorComponent extends PositionComponent with HasGameRef<PumaGame> {
  static const Duration animationDuration = Duration(seconds: 3);

  @override
  onLoad() {
    anchor = Anchor.center;
    position = Vector2(
      game.camera.viewport.size.x * .35,
      game.camera.viewport.size.y * 0.25,
    );

    add(
      SpriteComponent(
          sprite: Sprite(
            Flame.images.fromCache("fumigador_512.webp"),
          ),
          size: Vector2(128, 128),
          anchor: Anchor.center)
        ..add(
          RotateEffect.by(
            -0.25,
            EffectController(
                duration: 0.1, reverseDuration: 0.1, infinite: true),
          ),
        )
        ..add(
          MoveToEffect(
            Vector2(400, 10),
            EffectController(duration: animationDuration.inSeconds.toDouble()),
            onComplete: removeFromParent,
          ),
        ),
    );
    angle = 0.5;

    Future.delayed(Duration(seconds: animationDuration.inSeconds ~/ 2)).then(
      (_) => add(FumigationRainComponent()..position = Vector2(250, 25)),
    );

    return super.onLoad();
  }
}
