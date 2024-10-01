import 'package:flame/components.dart';
import 'package:game/flame_components/meal_component.dart';
import 'package:game/flame_components/puma_game.dart';
import 'package:game/flame_components/row_component.dart';

class MealsComponent extends PositionComponent with HasGameRef<PumaGame> {
  final List<MealComponent> mealsComponents = [];
  final Vector2 mealSize = Vector2(32, 32);
  static const double seedSpacing = 0;
  late final RowComponent columnComponent;

  @override
  onLoad() {
    loadSeeds();
    return super.onLoad();
  }

  void loadSeeds() {
    columnComponent = RowComponent(gap: seedSpacing);
    add(columnComponent);

    for (var meal in game.dietManager!.meals) {
      final mealsComponent = MealComponent(meal)..size = mealSize;

      mealsComponents.add(mealsComponent);
      columnComponent.add(mealsComponent);
    }
  }

  @override
  void update(double dt) {
    if (game.dietManager!.meals.length != mealsComponents.length) {
      final remainingMeals = game.dietManager!.meals.toSet();
      for (var mealsComponent in mealsComponents) {
        if (remainingMeals.contains(mealsComponent.meal)) {
          remainingMeals.remove(mealsComponent.meal);
        } else {
          mealsComponent.toDestroy = true;
        }
      }

      mealsComponents.removeWhere((mealComponent) {
        if (mealComponent.toDestroy) columnComponent.remove(mealComponent);
        return mealComponent.toDestroy;
      });

      for (var remainingMeal in remainingMeals) {
        final mealsComponent = MealComponent(remainingMeal)..size = mealSize;
        mealsComponents.add(mealsComponent);
        columnComponent.add(mealsComponent);
      }
    }

    super.update(dt);
  }
}
