import 'package:flame/game.dart';
import 'package:game/classes/tile_position.dart';

class DimetricLayout {
  final TilePosition tilePosition;
  final Vector2 size;
  final Vector2 scale;

  DimetricLayout({
    required this.tilePosition,
    required this.size,
    required this.scale,
  });

  static const double tileSpacing = 1.15;

  Vector2 get effectiveTileSize => size * tileSpacing;

  /// The current scaling factor for the dimetric view.
  double get scalingFactor => effectiveTileSize.y / effectiveTileSize.x;

  Vector2 get renderPosition {
    final halfTile = Vector2(
      effectiveTileSize.x * 0.5,
      (effectiveTileSize.y * 0.5) / scalingFactor,
    )..multiply(scale);

    final cartesianPosition = tilePosition.toVector2()..multiply(halfTile);

    return cartToIso(cartesianPosition) - halfTile;
  }

  /// Converts a coordinate from the cartesian space to the dimetric space.
  Vector2 cartToIso(Vector2 p) {
    final x = p.x - p.y;
    final y = ((p.x + p.y) * scalingFactor);
    return Vector2(x, y);
  }
}
