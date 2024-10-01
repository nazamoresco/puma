import 'dart:math';

import 'package:flame/extensions.dart';
import 'package:game/classes/crop.dart';
import 'package:game/classes/crop_states.dart';
import 'package:game/classes/farm_crop_history.dart';
import 'package:game/classes/farm_usability.dart';
import 'package:game/classes/player_incremental_feature_exposure.dart';
import 'package:game/classes/seed.dart';
import 'package:game/classes/tile_position.dart';
import 'package:game/classes/time_flow.dart';

enum TapResults {
  none,
  addCrop,
  removeCrop,
  deadParcel;
}

class TapResult {
  final TapResults type;
  final Crop? crop;
  final bool rotated;
  final bool isNewSeed;

  TapResult({
    required this.type,
    required this.crop,
    this.rotated = false,
    this.isNewSeed = false,
  });
}

class TickResult {
  bool isFumigationScheduled = false;

  TickResult();
}

class Farm {
  static const Size parcelsCount = Size(3, 3);
  static int get parcelsCountTotal =>
      (parcelsCount.width * parcelsCount.height).toInt();

  static TilePosition get centerPosition => TilePosition(
        (parcelsCount.width % 2 == 0
                ? parcelsCount.width
                : parcelsCount.width + 1) ~/
            2,
        (parcelsCount.height % 2 == 0
                ? parcelsCount.height
                : parcelsCount.height + 1) ~/
            2,
      );

  final Map<TilePosition, Crop> crops = {};
  final FarmUsability usability = FarmUsability();
  final FarmCropHistory history = FarmCropHistory();

  final Map<Seed, int> cropStorage = {};

  TapResult handleTap(
    TilePosition position, {
    Seed? selectedSeed,
    DateTime? currentDateTime,
    required PlayerIncrementalFeatureExposure featureExposure,
  }) {
    final crop = crops[position];

    if (crop == null) {
      if (selectedSeed == null || !usability.isUsable(position)) {
        return TapResult(
          type: TapResults.none,
          crop: crop,
        );
      }

      final newCrop = Crop(
        position: position,
        seed: selectedSeed,
        plantedOutOfSeason: featureExposure.areSeasonsExposed &&
            !selectedSeed.seasons.contains(currentDateTime?.season),
      );

      if (featureExposure.areCropRotationsExposed) {
        if (history.violatesRotationPrinciple(newCrop)) {
          usability.kill(newCrop.position, currentDateTime!);
          history.lastPlanted[newCrop.position] = null;
          return TapResult(
            type: TapResults.deadParcel,
            crop: newCrop,
          );
        }
      }

      final newSeed = crops.values.where((e) => e.seed.name == selectedSeed.name).isEmpty;
      crops[position] = newCrop;
      return TapResult(
        type: TapResults.addCrop,
        crop: newCrop,
        rotated: history.lastPlanted[position] != null,
        isNewSeed: newSeed,
      );
    } else if (crop.state == CropState.readyForHarvest ||
        crop.state == CropState.dead) {
      if (crop.state == CropState.readyForHarvest) {
        crop.state = CropState.harvested;
      }

      history.add(crop);
      crops.remove(position);
      cropStorage[crop.seed] ??= 0;
      cropStorage[crop.seed] = cropStorage[crop.seed]! + 1;

      return TapResult(type: TapResults.removeCrop, crop: crop);
    } else {
      return TapResult(type: TapResults.none, crop: null);
    }
  }

  DateTime? _scheduledFumigationAt;

  TickResult tick(
    DateTime currentDateTime,
    PlayerIncrementalFeatureExposure featureExposure,
  ) {
    final result = TickResult();

    for (Crop crop in crops.values) {
      crop.tick(currentDateTime);
    }

    // NM: Do plague calculation
    if (featureExposure.arePlaguesExposed) {
      final concentrations = calculateCropsConcentrations();
      for (Crop crop in crops.values) {
        if (concentrations[crop.seed]! > 0.5) {
          crop.bugsCount += 10;
        } else {
          crop.bugsCount -= 5;
          crop.bugsCount = min(crop.bugsCount, 0);
        }
      }
    }

    if (featureExposure.arePlaguesExposed &&
        maxBugCount > 100 &&
        (_scheduledFumigationAt == null ||
            currentDateTime.difference(_scheduledFumigationAt!) >
                const Duration(days: 7))) {
      _scheduledFumigationAt = currentDateTime;
      result.isFumigationScheduled = true;
    }

    usability.recoverLand(currentDateTime);

    return result;
  }

  int get maxBugCount {
    return crops.isEmpty
        ? 0
        : crops.values
            .reduce((value, element) =>
                element.bugsCount > value.bugsCount ? element : value)
            .bugsCount;
  }

  Map<Seed, double> calculateCropsConcentrations() {
    int total = parcelsCountTotal;
    Map<Seed, int> seedCount = {};
    for (var crop in crops.values) {
      seedCount[crop.seed] = seedCount[crop.seed] ?? 0;
      seedCount[crop.seed] = seedCount[crop.seed]! + 1;
    }

    if (total == 0) return {};

    Map<Seed, double> seedConcentrations = {};
    seedCount.forEach((seed, count) {
      seedConcentrations[seed] = (count / total);
    });

    return seedConcentrations;
  }

  fumigate() {
    for (Crop crop in crops.values) {
      crop.bugsCount = -50;
    }

    usability.planesLeft -= 1;
  }
}
