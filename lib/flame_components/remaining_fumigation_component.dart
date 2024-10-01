import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:game/flame_components/layout_component.dart';
import 'package:game/flame_components/puma_game.dart';
import 'package:game/flame_components/row_component.dart';

class RemainingFumigationComponent extends RowComponent
    with HasGameRef<PumaGame>, HasVisibility {
  int planesLeft = 3;

  Vector2 itemSize = Vector2.all(48);

  final List<SpriteComponent> orderedChildren = [];
  RemainingFumigationComponent()
      : super(alignment: LayoutComponentAlignment.end);

  @override
  FutureOr<void> onLoad() {
    isVisible = game.featureExposure.arePlaguesExposed;

    final image = Sprite(Flame.images.fromCache("icono_fumigar_2.webp"));

    orderedChildren.add(SpriteComponent(sprite: image, size: itemSize));
    orderedChildren.add(SpriteComponent(sprite: image, size: itemSize));
    orderedChildren.add(SpriteComponent(sprite: image, size: itemSize));

    addAll(orderedChildren);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    final gamePlanesLeft = game.farm?.usability.planesLeft ?? 0;
    if (gamePlanesLeft != 0 && gamePlanesLeft != planesLeft) {
      final index = gamePlanesLeft;
      orderedChildren.elementAt(index).opacity = .3;
      planesLeft = gamePlanesLeft;
    }

    isVisible = game.featureExposure.arePlaguesExposed;

    super.update(dt);
  }
}
