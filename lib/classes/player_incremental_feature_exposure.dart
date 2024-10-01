/// Slowly and incrementaly exposes the player to
/// more features in PUMA. We don't want to show everything
/// at once, because this can be intimidating for the player.
class PlayerIncrementalFeatureExposure {
  /// Whether the seasons feature was exposed to the player
  /// This includes: planting on season and season UI elements.
  bool areSeasonsExposed = false;

  /// Whether the crops rotation feature was exposed to the player
  /// This includes: border ui and usability implications
  bool areCropRotationsExposed = false;

  /// Whether the meals feature was exposed to the player
  /// This includes: choosing a meal.
  bool areMealsExposed = false;

  /// Whether the meals feature was exposed to the player
  /// This includes: choosing a meal.
  bool arePlaguesExposed = false;

  /// Wheter the hunger bar on tap is exposed.
  bool isHungerExposed = false;

  /// Whether the seed shop is exposed.
  bool isSeedShopExposed = true;

  /// Whether the kitchen is exposed.
  bool isKitchenExposed = true;
}
