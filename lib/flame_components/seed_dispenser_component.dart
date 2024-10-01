import 'package:flame/components.dart';
import 'package:flame/layout.dart';
import 'package:game/flame_components/layout_component.dart';
import 'package:game/flame_components/puma_game.dart';
import 'package:game/flame_components/row_component.dart';
import 'package:game/flame_components/seed_bag_component.dart';

class SeedDispenserComponent extends PositionComponent
    with HasGameRef<PumaGame> {
  final List<SeedBagComponent> seedBagComponents = [];
  final Vector2 seedSize = Vector2(64, 64);
  static const double seedSpacing = 32;
  late final RowComponent rowComponent;

  @override
  onLoad() {
    loadSeeds();
    return super.onLoad();
  }

  void loadSeeds() {
    rowComponent = RowComponent(
      alignment: LayoutComponentAlignment.center,
      gap: seedSpacing,
    );

    add(AlignComponent(child: rowComponent, alignment: Anchor.center));

    for (var seedBag in game.dispenser!.seedBags) {
      final seedBagComponent = SeedBagComponent(seedBag)
        ..size = seedSize
        ..anchor = Anchor.center;

      seedBagComponents.add(seedBagComponent);
      rowComponent.add(seedBagComponent);
    }

    if (seedBagComponents.isNotEmpty && game.selectedSeed == null) {
      seedBagComponents.first.select();
    }
  }

  @override
  void update(double dt) {
    if (game.dispenser!.seedBags.length != seedBagComponents.length) {
      final remainingSeedBags = game.dispenser!.seedBags;
      for (var seedBagComponent in seedBagComponents) {
        if (remainingSeedBags.contains(seedBagComponent.seedBag)) {
          remainingSeedBags.remove(seedBagComponent.seedBag);
        } else {
          seedBagComponent.toDestroy = true;
        }
      }

      seedBagComponents.removeWhere((seedBagComponent) {
        if (seedBagComponent.toDestroy) rowComponent.remove(seedBagComponent);
        return seedBagComponent.toDestroy;
      });

      for (var remainingSeed in remainingSeedBags) {
        final seedBagComponent = SeedBagComponent(remainingSeed)
          ..size = seedSize
          ..anchor = Anchor.center;
        seedBagComponents.add(seedBagComponent);
        rowComponent.add(seedBagComponent);
      }
    }

    if (seedBagComponents.isNotEmpty && game.selectedSeed == null) {
      seedBagComponents.first.select();
    }

    super.update(dt);
  }
}
