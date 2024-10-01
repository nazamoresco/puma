import 'package:game/classes/season.dart';
import 'package:game/classes/seeds_families.dart';

class Seed {
  final SeedFamily family;
  final String name;

  /// The name used by the artist (Ciro).
  ///
  /// We need this to fetch the assets.
  final String artName;

  /// Which season is the optimal to plant this seed.
  final List<Season> seasons;

  const Seed({
    required this.family,
    required this.name,
    required this.artName,
    required this.seasons,
  });

  static const pumpkin = Seed(
    family: SeedFamily.cucurbitaceae,
    name: "Zapallo",
    artName: "zapallo",
    seasons: [Season.spring, Season.summer],
  );

  static const tomato = Seed(
    family: SeedFamily.solanaceae,
    name: "Tomate",
    artName: "tomate",
    seasons: [Season.spring],
  );

  static const broccoli = Seed(
    family: SeedFamily.brassicaceae,
    name: "Brócoli",
    artName: "brocoli",
    seasons: [Season.spring, Season.fall],
  );

  static const carrot = Seed(
    family: SeedFamily.apiaceae,
    name: "Zanahoria",
    artName: "zanahoria",
    seasons: [Season.fall, Season.winter, Season.spring], // chantenay
  );

  static const cucumber = Seed(
    family: SeedFamily.cucurbitaceae,
    name: "Pepino",
    artName: "pepino",
    seasons: [Season.spring],
  );

  static const artichoke = Seed(
    family: SeedFamily.asteraceae,
    name: "Alcaucil",
    artName: "alcaucil",
    seasons: [Season.spring],
  );

  static const quinoa = Seed(
    family: SeedFamily.amaranthaceae,
    name: "Quinoa",
    artName: "quinoa",
    seasons: [Season.spring],
  );

  static const lettuce = Seed(
    family: SeedFamily.asteraceae,
    name: "Lechuga",
    artName: "lechuga",
    seasons: [Season.fall, Season.winter], // gallega
  );

  static const onion = Seed(
    family: SeedFamily.amaryllidaceae,
    name: "Cebolla",
    artName: "cebolla",
    seasons: [Season.fall],
  );

  static const potato = Seed(
    family: SeedFamily.solanaceae,
    name: "Papa",
    artName: "papa",
    seasons: [Season.spring, Season.summer],
  );

  // TO BE DELETED
  // static const corn = Seed(
  //   family: SeedFamily.poaceae,
  //   name: "Maiz",
  //   artName: "maiz",
  //   seasons: [Season.spring],
  // );

  static const allSeeds = [
    Seed.artichoke,
    Seed.broccoli,
    Seed.carrot,
    // Seed.corn,
    Seed.cucumber,
    Seed.lettuce,
    Seed.onion,
    Seed.pumpkin,
    Seed.quinoa,
    Seed.tomato,
  ];

  String get icon => "icono_$artName.webp";
}
