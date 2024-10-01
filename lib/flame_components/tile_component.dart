import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:game/classes/tile_position.dart';
import 'package:game/flame_components/dimetric_layout.dart';
import 'package:game/flame_components/puma_game.dart';
import 'package:game/functions/scale_keeping_aspect_ratio.dart';

mixin TileComponent on PositionComponent, HasGameRef<PumaGame> {
  TilePosition get tilePosition;

  static Vector2 tileSize(PumaGame game) {
    return scaleKeepingAspectRatio(
      aspectRatio: Vector2(1, 0.5),
      target: Vector2(-1, max(game.camera.viewport.size.y * 0.1, 60)),
    );
  }

  @override
  FutureOr<void> onLoad() {
    size = tileSize(game);
    anchor = Anchor.center;
    position = DimetricLayout(
      tilePosition: tilePosition,
      size: size,
      scale: scale,
    ).renderPosition;
    return super.onLoad();
  }

  bool isPointInRhomboid(Vector2 point) {
    final p = point;

    final a = Vector2(0, size.y / 2);
    final b = Vector2(size.x / 2, size.y);
    final c = Vector2(size.x, size.y / 2);
    final d = Vector2(size.x / 2, 0);

    Vector2 q = Vector2(0.5 * (a.x + c.x), 0.5 * (a.y + c.y)); // Center point
    double halfWidth = 0.5 * (a.distanceTo(c)); // Half-width
    double halfHeight = 0.5 * (b.distanceTo(d)); // Half-height

    Vector2 u = Vector2((c.x - a.x) / (2 * halfWidth),
        (c.y - a.y) / (2 * halfWidth)); // Unit vector in x-direction
    Vector2 v = Vector2((d.x - b.x) / (2 * halfHeight),
        (d.y - b.y) / (2 * halfHeight)); // Unit vector in y-direction

    Vector2 w = p - q;
    double xabs = (w.dot(u)).abs();
    double yabs = (w.dot(v)).abs();

    return (xabs / halfWidth + yabs / halfHeight) <= 1;
  }

  @override
  bool containsLocalPoint(Vector2 point) {
    return isPointInRhomboid(point);
  }
}
