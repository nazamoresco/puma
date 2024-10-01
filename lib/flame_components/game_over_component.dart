import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:game/flame_components/puma_game.dart';
import 'package:game/flame_components/restart_component.dart';
import 'package:game/functions/scale_keeping_aspect_ratio.dart';

class GameOverComponent extends SpriteComponent
    with HasGameRef<PumaGame>, TapCallbacks {
  @override
  FutureOr<void> onLoad() {
    final background = Flame.images.fromCache("1080_fondo.webp");
    size = scaleKeepingAspectRatio(
      aspectRatio: background.size,
      target: game.camera.viewport.size,
    );

    anchor = Anchor.topCenter;
    position = Vector2(
      game.initialCameraPosition.x,
      game.world.size.y * 0.5,
    );
    sprite = Sprite(background);

    final grassImage = Flame.images.fromCache("1080_pasto.webp");
    final finalGrassSize = scaleKeepingAspectRatio(
      aspectRatio: grassImage.size,
      target: Vector2(size.x, -1),
    );

    add(
      SpriteComponent(
        sprite: Sprite(grassImage),
        size: finalGrassSize,
        position: Vector2(0, -finalGrassSize.y),
      ),
    );

    final skullImage = Flame.images.fromCache("1080_calavera.webp");
    add(SpriteComponent(
      sprite: Sprite(skullImage),
      size: scaleKeepingAspectRatio(
        aspectRatio: skullImage.size,
        target: Vector2(-1, size.y * .1),
      ),
      position: Vector2(
        size.x * .6,
        size.y * .43,
      ),
    ));

    final gameOverImage = Flame.images.fromCache("1080_game over.webp");
    add(SpriteComponent(
      sprite: Sprite(gameOverImage),
      size: scaleKeepingAspectRatio(
        aspectRatio: skullImage.size,
        target: Vector2(size.x * .28, -1),
      ),
      position: Vector2(
        size.x * 0.2,
        size.y * 0.405,
      ),
    ));

    add(
      RestartComponent()
        ..position = Vector2(
          size.x * 0.45,
          size.y * 0.555,
        ),
    );

    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.restartGame();
    super.onTapDown(event);
  }
}
