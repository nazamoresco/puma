import 'package:game/classes/crop.dart';
import 'package:game/classes/tile_position.dart';

class FarmCropHistory {
  int historicalCropCount = 0;
  int rotationsCount = 0;
  final Map<TilePosition, Crop?> lastPlanted = {};

  bool violatesRotationPrinciple(Crop crop) {
    if (lastPlanted[crop.position] == null) return false;
    return lastPlanted[crop.position]!.seed == crop.seed;
  }

  bool isRotation(Crop crop) {
    return lastPlanted[crop.position] != null &&
        !violatesRotationPrinciple(crop);
  }

  Crop? latest(TilePosition position) => lastPlanted[position];

  void add(Crop crop) {
    historicalCropCount += 1;
    if (isRotation(crop)) rotationsCount += 1;
    lastPlanted[crop.position] = (crop);
  }
}
