import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class PlagueComponent extends SpriteComponent {
  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(
      Flame.images.fromCache("parcela_infectada_3.webp"),
    );

    super.onLoad();
  }
}
