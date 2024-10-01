import 'package:game/classes/farm.dart';
import 'tile_position.dart';

class FarmUsability {
  /// How many planes does the player has left before he loses
  int planesLeft = 3;

  final Map<TilePosition, DateTime> _destroyedAt = {};

  bool isUsable(TilePosition position) {
    return _destroyedAt[position] == null;
  }

  void kill(TilePosition position, DateTime currentTime) {
    _destroyedAt[position] = currentTime;
  }

  /// How long does it take for a piece of land to recover
  static const Duration _recoverTime = Duration(days: 7 * 4);

  /// It checks whether any land had time to recover
  void recoverLand(DateTime currentTime) {
    for (var position in _destroyedAt.keys.toList()) {
      if (currentTime.difference(_destroyedAt[position]!) > _recoverTime) {
        _destroyedAt.remove(position);
      }
    }
  }

  bool get isDestroyed =>
      planesLeft <= 0 || _destroyedAt.length >= Farm.parcelsCountTotal;
}
