import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:game/classes/dispenser.dart';
import 'package:game/classes/recipe.dart';
import 'package:game/classes/seed.dart';

class Cookbook with ChangeNotifier {
  final Set<Recipe> allRecipes = {
    Recipe.artichokeWithQuinoa,
    Recipe.gazpacho,
    Recipe.broccoliCarrot,
    // Recipe.carrotPie,
    Recipe.classicSalad,
    Recipe.pumpkinRecipe,
  };

  /// The recipes the player has unlocked
  /// and can start requiring
  Set<Recipe> unlockedRecipes = {};

  Set<Recipe> unlockableRecipes = {};

  Set<Recipe> get lockedRecipes => unlockableRecipes.difference(
        unlockedRecipes,
      );

  // NOTE: Maybe we can return boolean whether we unlocked a new recipe or not.
  Recipe? combine(List<Seed> ingredients) {
    final recipe = unlockableRecipes.firstWhereOrNull((recipe) {
      return ingredients.toSet().containsAll(recipe.seeds) &&
          recipe.seeds.toSet().containsAll(ingredients);
    });

    return recipe;
  }

  /// Whether the current ingredients are in a good path
  /// to unlocking a new recipe.
  goodPathToLockedRecipe(List<Seed> ingredients, Dispenser dispenser) {
    final recipe = lockedRecipes.firstWhereOrNull(
      (recipe) {
        if (!recipe.seeds.toSet().containsAll(ingredients)) return false;

        // In some cases ingredient repetition is not allowed.
        if (ingredients.length - ingredients.toSet().length >
            3 - recipe.seeds.length) {
          return false;
        }

        final toPlace = recipe.seeds.toSet().difference(ingredients.toSet());
        final areEnoughHarvests = dispenser.harvests
                    .where((seedBag) => recipe.seeds.contains(seedBag.seed))
                    .map<int>((seedBag) => seedBag.count)
                    .sum +
                ingredients.length >=
            3;

        final inStock = toPlace.every(
          (seed) => dispenser.getHarvest(seed) != null,
        );
        return inStock && areEnoughHarvests;
      },
    );

    return recipe != null;
  }

  /// Whether the current ingredients are in a good path
  /// to making a unlocked recipe.
  goodPathToUnlockedRecipe(List<Seed> ingredients, Dispenser dispenser) {
    final recipe = unlockedRecipes.firstWhereOrNull(
      (recipe) {
        if (!recipe.seeds.toSet().containsAll(ingredients)) return false;

        // In some cases ingredient repetition is not allowed.
        if (ingredients.length - ingredients.toSet().length >
            3 - recipe.seeds.length) {
          return false;
        }

        final toPlace = recipe.seeds.toSet().difference(ingredients.toSet());
        final areEnoughHarvests = dispenser.harvests
                    .where((seedBag) => recipe.seeds.contains(seedBag.seed))
                    .map<int>((seedBag) => seedBag.count)
                    .sum +
                ingredients.length >=
            3;

        final inStock = toPlace.every(
          (seed) => dispenser.getHarvest(seed) != null,
        );
        return inStock && areEnoughHarvests;
      },
    );

    return recipe != null;
  }
}
