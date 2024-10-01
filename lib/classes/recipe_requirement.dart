import 'package:game/classes/recipe.dart';
import 'package:game/classes/seed.dart';

class RecipeRequirement {
  final Recipe recipe;

  /// Ingredientes for a batch of the recipe.
  final Map<Seed, int> ingredients;

  const RecipeRequirement({
    required this.recipe,
    required this.ingredients,
  }); 
}
