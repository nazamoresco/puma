import 'package:flutter/material.dart';
import 'package:game/classes/diet_manager.dart';
import 'package:game/classes/recipe.dart';
import 'package:game/classes/seed.dart';
import 'package:game/classes/seed_bag.dart';

class Dispenser with ChangeNotifier {
  final Map<Seed, SeedBag> _seedBagsMap = {
    Seed.tomato: SeedBag(Seed.tomato, count: 2),
  };

  List<SeedBag> get seedBags => _seedBagsMap.values.toList();

  void removeSeedBag(Seed seed) {
    _seedBagsMap.remove(seed);
  }

  SeedBag? getBag(Seed seed) => _seedBagsMap[seed];

  final Map<Seed, SeedBag> _harvests = {};

  List<SeedBag> get harvests => _harvests.values.toList();

  SeedBag? getHarvest(Seed seed) => _harvests[seed];

  Dispenser();

  void stock(Seed seed) {
    var bag = _seedBagsMap[seed];
    if (bag == null) {
      _seedBagsMap[seed] = SeedBag(seed, count: DietManager.batchSize);
    } else {
      _seedBagsMap[seed]!.count += DietManager.batchSize;
    }
  }

  void harvest(Seed seed) {
    var bag = _harvests[seed];
    if (bag == null) {
      _harvests[seed] = SeedBag(seed, count: DietManager.batchSize);
    } else {
      _harvests[seed]!.count += DietManager.batchSize;
    }
  }

  /// TO DELETE
  /// Adds the seeds needed to produce for a recipe
  void stockForRecipe(Recipe recipe) {
    for (var seed in recipe.seeds) {
      var bag = _seedBagsMap[seed];
      if (bag == null) {
        _seedBagsMap[seed] = SeedBag(seed, count: DietManager.batchSize);
      } else {
        _seedBagsMap[seed]!.count += DietManager.batchSize;
      }
    }
  }

  void removeFromHarvest(Seed seed) {
    _harvests[seed]!.count -= 1;
    if (_harvests[seed]!.count == 0) {
      _harvests.remove(seed);
    }
  }
}
