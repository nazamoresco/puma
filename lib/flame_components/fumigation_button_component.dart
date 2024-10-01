import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:game/flame_components/fumigator_component.dart';
import 'package:game/flame_components/puma_game.dart';

class FumigationButtonComponent extends SpriteComponent
    with HasGameRef<PumaGame>, TapCallbacks {
  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(Flame.images.fromCache("icono_fumigar_2.webp"));
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.camera.viewport.add(FumigatorComponent());
    Future.delayed(FumigatorComponent.animationDuration).then(
      (_) => game.farm!.fumigate(),
    );
    super.onTapDown(event);
  }
}
