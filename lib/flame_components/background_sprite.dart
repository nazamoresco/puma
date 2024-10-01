import 'package:flame/components.dart';
import 'package:game/flame_components/puma_game.dart';
import 'package:game/functions/scale_keeping_aspect_ratio.dart';

class BackgroundSprite extends PositionComponent with HasGameRef<PumaGame> {
  BackgroundSprite();

  @override
  Future<void> onLoad() async {
    size = scaleKeepingAspectRatio(
      aspectRatio: Vector2(1920, 1080),
      target: Vector2(
        game.camera.viewport.size.x * 1.5,
        game.camera.viewport.size.y,
      ),
    );

    anchor = Anchor.center;
    game.camera.viewfinder.zoom = 1;
  }
}
