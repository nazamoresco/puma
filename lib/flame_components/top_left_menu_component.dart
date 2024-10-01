import 'dart:async';

import 'package:flame/components.dart';
import 'package:game/flame_components/cookbook_button_component.dart';
import 'package:game/flame_components/puma_game.dart';
import 'package:game/flame_components/season_info_component.dart';
import 'package:game/flame_components/seed_shop_button_component.dart';

class TopLeftMenuComponent extends PositionComponent with HasGameRef<PumaGame> {
  @override
  FutureOr<void> onLoad() {
    double gap = 40;
    final currentPosition = Vector2(0, 0);

    final seasonInfoComponent = SeasonInfoComponent()
      ..anchor = Anchor.topLeft
      ..position = currentPosition;

    add(seasonInfoComponent);

    currentPosition.y += gap + seasonInfoComponent.size.y;

    final seedShopButtonComponent = SeedShopButtonComponent()
      ..anchor = Anchor.topLeft
      ..position = currentPosition;

    add(seedShopButtonComponent);

    currentPosition.y += gap + seedShopButtonComponent.size.y / 2;

    final cookbookButtonComponent = CookbookButtonComponent()
      ..anchor = Anchor.topLeft
      ..position = currentPosition;

    add(cookbookButtonComponent);

    currentPosition.y += gap + cookbookButtonComponent.size.y / 2;

    return super.onLoad();
  }
}
