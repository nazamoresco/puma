import 'package:collection/collection.dart';
import 'package:game/classes/recipe_requirement.dart';
import 'package:game/classes/season.dart';
import 'package:game/classes/seed.dart';

class Recipe {
  final String name;
  final List<Seed> seeds;
  final String imagePath;

  const Recipe({
    required this.name,
    required this.seeds,
    required this.imagePath,
  });

  static const gazpacho = Recipe(
    name: "Gazpacho",
    seeds: [Seed.tomato],
    imagePath: "receta_gazpacho.webp",
  );

  static const soup = Recipe(
    name: "Sopa de calabaza y papa",
    seeds: [Seed.onion, Seed.pumpkin, Seed.potato],
    imagePath: "receta_sopa_de_papa_y_calabaza.webp",
  );

  static const pumpkinRecipe = Recipe(
    name: "Calabaza con tomates secos y brocoli",
    seeds: [Seed.pumpkin, Seed.tomato, Seed.broccoli],
    imagePath: "receta_calabaza_con_tomates_y_brocoli.webp",
  );

  static const tortilla = Recipe(
    name: "Tortilla",
    seeds: [Seed.potato, Seed.onion],
    imagePath: "receta_tortilla.webp",
  );

  static const broccoliCarrot = Recipe(
    name: "Brocoli con zanahoria y pepino",
    seeds: [Seed.carrot, Seed.cucumber, Seed.broccoli],
    imagePath: "receta_brocoli_con_pepino_y_zanahoria.webp",
  );

  static const artichokeWithQuinoa = Recipe(
    name: "Alcachofas rellenas de quinoa",
    seeds: [Seed.artichoke, Seed.quinoa],
    imagePath: "receta_alcachofas_rellenas.webp",
  );

  static const classicSalad = Recipe(
    name: "Ensalada",
    seeds: [Seed.lettuce, Seed.tomato, Seed.onion],
    imagePath: "receta_ensalada.webp",
  );

  static const quinoaBroccoliSalad = Recipe(
    name: "Ensalada de Quinoa y Brócoli",
    seeds: [Seed.quinoa, Seed.broccoli],
    imagePath: "receta_ensalada_quinoa_brocoli.webp",
  );

  static const potatoCarrotCasserole = Recipe(
    name: "Cazuela de Papas y Zanahorias",
    seeds: [Seed.potato, Seed.carrot],
    imagePath: "receta_cazuela_papas_zanahorias.webp",
  );

  RecipeRequirement get requires {
    final ingredients = <Seed, int>{};
    for (Seed seed in seeds) {
      ingredients[seed] = 100;
    }

    return RecipeRequirement(recipe: this, ingredients: ingredients);
  }

  List<Season> get seasons => seeds.map((seed) => seed.seasons).flattened.toSet().toList();
}
