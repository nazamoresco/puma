import 'package:flutter/material.dart';
import 'package:game/classes/crop.dart';
import 'package:game/classes/recipe.dart';
import 'package:game/classes/recipe_requirement.dart';
import 'package:game/classes/dispenser.dart';

class RecipeRequirements with ChangeNotifier {
  List<RecipeRequirement> requirements = [];

  RecipeRequirements();

  void require(Recipe recipe, Dispenser dispenser) {
    requirements.add(recipe.requires);
    // dispenser.add(recipe.requires.ingredients);
    notifyListeners();
  }

  /// Satisfies current requirements using the crop.
  void use(Crop crop) {
    for (var demand in requirements) {
      if (!demand.ingredients.keys.contains(crop.seed)) continue;
      if (demand.ingredients[crop.seed] == 0) continue;
      demand.ingredients[crop.seed] = demand.ingredients[crop.seed]! - 1;
      if (demand.ingredients.values.every((count) => count <= 0)) {
        requirements.remove(demand);
      }
      notifyListeners();
      return;
    }
  }
}
