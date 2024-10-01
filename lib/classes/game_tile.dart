import 'package:game/classes/crop.dart';
import 'package:game/classes/position.dart';
import 'package:game/classes/tile_type.dart';

class GameTile {
  final TileType type;
  final Crop? crop;
  final List<Crop> cropHistory;
  final Position position;
  final double health;

  /// Once it's life is 0 this tile can't be used for planting seeds.
  /// Maybe a better name would be 'agotamiento', but problem for later.
  double _life = 1.0;

  double get life => _life;

  set life(double newLife) {
    if (newLife < 0.0) {
      throw Exception("The life can't be less than 0% (0.0)");
    } else if (newLife > 1.0) {
      throw Exception("The life can't be more than 100% (1.0)");
    } else {
      _life = newLife;
    }
  }

  GameTile({
    required this.type,
    this.crop,
    required this.position,
    required this.cropHistory,
    required this.health,
  });
}
