import 'dart:async';

import 'package:flame/components.dart';
import 'package:game/flame_components/coins_component.dart';
import 'package:game/flame_components/go_to_questionaire_button.dart';
import 'package:game/flame_components/monocultive_percentage_component.dart';
import 'package:game/flame_components/menu_button_component.dart';
import 'package:game/flame_components/puma_game.dart';
import 'package:game/flame_components/remaining_fumigation_component.dart';

class TopRightMenuComponent extends PositionComponent
    with HasGameRef<PumaGame> {
  double rightMargin = 16;
  int verticalPadding = 4;


  @override
  FutureOr<void> onLoad() {
    double currentY = 0;

    final pauseButtonComponent = MenuButtonComponent()
      ..anchor = Anchor.topRight
      ..position = Vector2(-rightMargin, currentY);

    add(pauseButtonComponent);

    currentY += pauseButtonComponent.size.y + verticalPadding;

    final goToQuestionaireButton = GoToQuestionaireButton()
      ..anchor = Anchor.topRight
      ..position = Vector2(-rightMargin, currentY);

    add(goToQuestionaireButton);

    currentY += goToQuestionaireButton.size.y + verticalPadding;

    final coinsComponent = CoinsComponent()
      ..anchor = Anchor.topRight
      ..position = Vector2(-rightMargin, currentY);

    add(coinsComponent);

    currentY += pauseButtonComponent.size.y + verticalPadding;

    final totalUsabilityButton = RemainingFumigationComponent()
      ..position = Vector2(-rightMargin, currentY);

    add(totalUsabilityButton);

    currentY += totalUsabilityButton.itemSize.y + verticalPadding;

    final monocultivePercentageComponent = MonocultivePercentageComponent();

    add(
      monocultivePercentageComponent
        ..anchor = Anchor.topRight
        ..position = Vector2(-rightMargin, currentY),
    );

    return super.onLoad();
  }
}
