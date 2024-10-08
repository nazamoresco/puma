import 'dart:async';

import 'package:flame/components.dart';
import 'package:game/flame_components/column_component.dart';
import 'package:game/flame_components/cookbook_button_component.dart';
import 'package:game/flame_components/puma_game.dart';
import 'package:game/flame_components/season_info_component.dart';
import 'package:game/flame_components/seed_shop_button_component.dart';

class TopLeftMenuComponent extends PositionComponent with HasGameRef<PumaGame> {
  @override
  FutureOr<void> onLoad() {
    final column = ColumnComponent()..anchor = Anchor.topLeft;

    column.add(SeasonInfoComponent());
    column.add(SeedShopButtonComponent());
    column.add(CookbookButtonComponent());
    add(column);

    return super.onLoad();
  }
}
