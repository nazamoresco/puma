import 'dart:math';

import 'package:game/classes/tile_position.dart';

class Position {
  final int x;
  final int y;

  const Position(this.x, this.y);

  /// Create a unique hash code through the use of a [pairing function](https://en.wikipedia.org/wiki/Pairing_function)
  @override
  int get hashCode => (1/2 * (x + y) * (x + y + 1) + y).toInt();

  @override
  bool operator ==(Object other) => hashCode == other.hashCode;

  int tilesDifference(Position position) {
    return sqrt(pow(position.x - x, 2) + pow(position.y - y, 2)).toInt();
  }

  @override
  String toString() {
    return "Position($x, $y)";
  }

  List<Position> surroundingPositions() {
    return [
      Position(x + 1, y + 1),
      Position(x + 1, y),
      Position(x + 1, y - 1),
      Position(x, y + 1),
      Position(x, y),
      Position(x, y - 1),
      Position(x - 1, y + 1),
      Position(x - 1, y),
      Position(x - 1, y - 1),
    ];
  }

  TilePosition toNewPosition() => TilePosition(x, y);
}
