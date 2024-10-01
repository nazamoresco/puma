import 'package:game/classes/seed.dart';

class SeedBag {
  /// How many seeds the bag holds
  int count;

  /// What kind of seed the bag holds
  final Seed seed;

  SeedBag(this.seed, {required this.count});
}
