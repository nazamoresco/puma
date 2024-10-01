import 'dart:math';

import 'package:flame/game.dart';
import 'package:game/classes/position.dart';

class TilePosition {
  final int x;
  final int y;

  const TilePosition(this.x, this.y);

  /// Create a unique hash code through the use of a [pairing function](https://en.wikipedia.org/wiki/Pairing_function)
  @override
  int get hashCode => (1/2 * (x + y) * (x + y + 1) + y).toInt();

  @override
  bool operator ==(Object other) => hashCode == other.hashCode;

  int tilesDifference(TilePosition tilePosition) {
    return sqrt(pow(tilePosition.x - x, 2) + pow(tilePosition.y - y, 2))
        .toInt();
  }

  @override
  String toString() {
    return "TilePosition($x, $y)";
  }

  Vector2 toVector2() {
    return Vector2(x.toDouble(), y.toDouble());
  }

  List<TilePosition> surroundingTilePositions() {
    return [
      TilePosition(x + 1, y + 1),
      TilePosition(x + 1, y),
      TilePosition(x + 1, y - 1),
      TilePosition(x, y + 1),
      TilePosition(x, y),
      TilePosition(x, y - 1),
      TilePosition(x - 1, y + 1),
      TilePosition(x - 1, y),
      TilePosition(x - 1, y - 1),
    ];
  }

  Position toOldPosition() => Position(x, y);
}
