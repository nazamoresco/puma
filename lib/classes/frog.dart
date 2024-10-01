import 'dart:async';
import 'dart:math';

import 'package:game/classes/recipe.dart';

class Frog {
  String comment = "";

  final Map<Recipe, int> recipePay = {
    Recipe.gazpacho: 10,
  };

  late Timer _timer;

  void yap() {
    talk(null);
    _timer = Timer.periodic(const Duration(seconds: 8), (_) {
      talk(null);
    });
  }


  void talk(Recipe? recipe) {
    if (recipe == null) {
      const thingsToSay = [
        "Tengo hambre! Quiero comida....",
        "Tocá los ingredientes para hacer una receta!",
        "Cada receta tiene 3 ingredientes...",
        "Una receta puede repetir ingredientes...",
        "El verde te guia a una nueva receta...",
        "El azul te lleva a repetir recetas...",
        "Te dare un par de monedas por lo que cocines...",
        "Puedes recuperar las monedas de una semilla en el tacho de basura...",
      ];

      comment = thingsToSay[Random().nextInt(thingsToSay.length)];
      return;
    }

    if (recipe == Recipe.gazpacho) {
      comment = "${recipe.name}! Me encanta! Toma ${recipePay[recipe]} monedas.";
      return;
    }

    recipePay[recipe] ??= 3;
    if (recipePay[recipe]! <= 3) {
      recipePay[recipe] = recipePay[recipe]! + 2;
      comment = "Hmmmm. ${recipe.name}. No esta mal. Toma ${recipePay[recipe]} monedas";
      return;
    } else if (recipePay[recipe]! <= 5) {
      recipePay[recipe] = recipePay[recipe]! + 2;
      comment = "${recipe.name}, sabroso. Toma ${recipePay[recipe]} monedas";
      return;
    } else if (recipePay[recipe]! <= 7) {
      recipePay[recipe] = recipePay[recipe]! + 3;
      comment = "${recipe.name}! Me encanta! Toma ${recipePay[recipe]} monedas!";
      return;
    }
  }
}
