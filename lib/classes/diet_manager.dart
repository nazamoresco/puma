import 'package:game/classes/meal.dart';
import 'package:game/classes/recipe.dart';
import 'package:game/classes/season.dart';
import 'package:game/classes/seed.dart';

class DietManager {
  static const int batchSize = 1;

  final List<Meal> producedMeals = [];
  final List<Meal> meals = [];
  final Map<Recipe, int> chosenMeals = {};

  List<Recipe> get recipes => meals.map((meal) => meal.recipe).toList();

  void add(Recipe recipe) {
    chosenMeals[recipe] ??= 0;
    chosenMeals[recipe] = chosenMeals[recipe]! + batchSize;

    if (recipes.contains(recipe)) {
      meals.singleWhere((meal) => meal.recipe == recipe).count += 1;
    } else {
      meals.add(Meal(recipe: recipe, count: batchSize));
    }
  }

  void utilizeHarvest(
    Map<Seed, int> cropStorage,
    void Function(Meal meal) onMealProduced,
  ) {
    for (var meal in meals) {
      if (meal.recipe.seeds.every((seed) => (cropStorage[seed] ?? 0) >= 1)) {
        meal.count -= 1;
        final producedMeal = Meal(recipe: meal.recipe, count: 1);
        onMealProduced(producedMeal);
        producedMeals.add(producedMeal);

        for (var seed in meal.recipe.seeds) {
          cropStorage[seed] = cropStorage[seed]! - 1;
        }
      }
    }

    meals.removeWhere((meal) => meal.count == 0);
  }

  List<Recipe> calculateNextTwoOptions(
    Set<Recipe> recipes,
    Season currentSeason,
  ) {
    // The first two time you have no option
    if ((chosenMeals[Recipe.gazpacho] ?? 0) <= 2) {
      return [Recipe.gazpacho, Recipe.gazpacho];
    }

    // Bad options
    Recipe? offSeasonRecipe;

    // Good options
    Recipe? onSeasonRecipe;
    Recipe? unusualRecipe;

    for (var recipe in recipes.toList()..shuffle()) {
      offSeasonRecipe ??= recipe;
      if (offSeasonRecipe.seasons
              .where((season) => season == currentSeason)
              .length >=
          recipe.seasons.where((season) => season == currentSeason).length) {
        offSeasonRecipe = recipe;
      }

      unusualRecipe ??= recipe;
      final currentMealsCount = meals.contains(unusualRecipe)
          ? meals
              .singleWhere((element) => element.recipe == unusualRecipe)
              .count
          : 0;
      final recipeMealsCount = meals.contains(recipe)
          ? meals.singleWhere((element) => element.recipe == recipe).count
          : 0;

      if (currentMealsCount > recipeMealsCount) {
        unusualRecipe = recipe;
      }

      onSeasonRecipe ??= recipe;
      if (onSeasonRecipe.seasons
              .where((season) => season == currentSeason)
              .length <
          onSeasonRecipe.seasons
              .where((season) => season == currentSeason)
              .length) {
        onSeasonRecipe = recipe;
      }
    }

    // Very used recipe
    final usualRecipe = meals
        .reduce((curr, next) => curr.count > next.count ? curr : next)
        .recipe;

    final badOptions = [offSeasonRecipe, usualRecipe];
    badOptions.shuffle();
    final badOption = badOptions.first;

    final goodOptions = [onSeasonRecipe, unusualRecipe];
    goodOptions.shuffle();
    final goodOption = goodOptions.first;

    return [goodOption!, badOption!]..shuffle();
  }
}
