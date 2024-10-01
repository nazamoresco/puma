import 'package:game/classes/seed.dart';

enum CropState {
  planted,
  cotyledons,
  growing0,
  growing1,
  growing2,
  readyForHarvest,
  harvested,
  dead;

  String imagePath({required Seed seed}) {
    switch (this) {
      case CropState.planted:
        return 'brote_1_solo.webp';
      case CropState.cotyledons:
        return "cotiledones_1.webp";
      case CropState.growing0:
        return '${seed.artName}_0.webp';
      case CropState.growing1:
        return '${seed.artName}_1.webp';
      case CropState.growing2:
        return '${seed.artName}_2.webp';
      case CropState.readyForHarvest:
        return '${seed.artName}_3.webp';
      case CropState.dead:
        return 'cultivo_muerto.webp';
      case CropState.harvested:
        return "cultivo_muerto.webp"; // Shouldn't be displayed
    }
  }
}
