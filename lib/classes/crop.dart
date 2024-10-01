import 'dart:math';

import 'package:game/classes/crop_states.dart';
import 'package:game/classes/seed.dart';
import 'package:game/classes/tile_position.dart';

class Crop {
  /// It returns the image path for the corresponding state of the crop.
  String get imagePath => state.imagePath(seed: seed);

  final TilePosition position;

  CropState state = CropState.planted;

  // NM: Set in the first tick
  DateTime? plantedTime;

  final Seed seed;

  /// NM: How many bugs the crop has.
  int bugsCount = 1;

  /// NM: Timestamp when the crop started
  /// being infested.
  DateTime? infestedTime;

  final bool plantedOutOfSeason;

  Crop(
      {required this.position,
      required this.seed,
      required this.plantedOutOfSeason});

  static const int readyForHarvestDays = 14;

  // NM: We don't want to save the progress so we don't
  // have to calculate it every tick.
  double progressToHarvestingState = 0;
  double calculateProgressToHarvestingState(DateTime currentTime) {
    if (plantedTime == null) return 0;
    Duration age = currentTime.difference(plantedTime!);

    return min(age.inDays / readyForHarvestDays, 1.0);
  }

  bool get isInfested => bugsCount > 50;

  int get penalityMultiplier => plantedOutOfSeason ? 2 : 1;

  // Returns if it changes
  Future<bool> tick(DateTime currentTime) async {
    plantedTime ??= currentTime;
    progressToHarvestingState = calculateProgressToHarvestingState(currentTime);
    Duration age = currentTime.difference(plantedTime!);

    if (isInfested && infestedTime == null) {
      infestedTime = currentTime;
    }

    if (!isInfested && infestedTime != null) {
      infestedTime = null;
    }

    if (infestedTime != null) {
      Duration infested = currentTime.difference(infestedTime!);
      if (infested > const Duration(days: 14)) {
        state = CropState.dead;
        return true;
      }
    }

    switch (state) {
      case CropState.planted:
        if (age > const Duration(days: 2) * penalityMultiplier) {
          state = CropState.cotyledons;
          return true;
        }

        return false;
      case CropState.cotyledons:
        if (age > const Duration(days: 4) * penalityMultiplier) {
          state = CropState.growing0;
          return true;
        }

        return false;
      case CropState.growing0:
        if (age > const Duration(days: 6) * penalityMultiplier) {
          state = CropState.growing1;
          return true;
        }

        return false;
      case CropState.growing1:
        if (age > const Duration(days: 8) * penalityMultiplier) {
          state = CropState.growing2;
          return true;
        }

        return false;
      case CropState.growing2:
        if (age >
            const Duration(days: readyForHarvestDays) * penalityMultiplier) {
          state = CropState.readyForHarvest;
          return true;
        }

        return false;
      case CropState.readyForHarvest:
        if (age > const Duration(days: 50) * penalityMultiplier) {
          state = CropState.dead;
          return true;
        }

        return false;
      case CropState.dead:
        return false;
      case CropState.harvested:
        return false;
    }
  }
}
