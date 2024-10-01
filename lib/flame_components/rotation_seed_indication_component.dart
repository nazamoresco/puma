import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:game/classes/crop.dart';
import 'package:game/classes/crop_states.dart';
import 'package:game/classes/seed.dart';
import 'package:game/flame_components/parcel_border_component.dart';
import 'package:game/flame_components/puma_game.dart';
import 'package:game/functions/scale_keeping_aspect_ratio.dart';

class RotationSeedIndicationComponent extends SpriteComponent
    with HasVisibility, HasGameRef<PumaGame>, ParentIsA<ParcelBorderComponent> {
  Crop? crop;

  /// Red cross around the seed so they don't
  /// plant it again
  ///
  late CircleComponent circleComponent;
  late RectangleComponent crossComponent;

  RotationSeedIndicationComponent();

  @override
  FutureOr<void> onLoad() {
    isVisible = false;

    // Placeholder is carrot, but we don't show it anyways.
    final image = Flame.images.fromCache(Seed.carrot.icon);
    size = scaleKeepingAspectRatio(
      aspectRatio: image.size,
      target: size,
    );
    sprite = Sprite(image);

    circleComponent = CircleComponent(
      radius: max(size.x, size.y) * .5,
      anchor: Anchor.center,
      position: size * .5,
      paint: Paint()
        ..strokeWidth = 5
        ..color = Colors.red
        ..style = PaintingStyle.stroke,
    );

    add(circleComponent);

    crossComponent = RectangleComponent(
      angle: 4,
      size: Vector2(max(size.x, size.y), 5),
      anchor: Anchor.center,
      position: size * .5,
      paint: Paint()..color = Colors.red.withOpacity(0.6),
    );

    add(crossComponent);

    return super.onLoad();
  }

  Crop? get _fetchCrop {
    return game.farm?.crops[parent.tilePosition] ??
        game.farm?.history.latest(parent.tilePosition);
  }

  @override
  void update(double dt) {
    final fetchedCrop = _fetchCrop;
    if (fetchedCrop == null && crop != null) {
      crop = null;
    } else if (fetchedCrop != null && fetchedCrop != crop) {
      crop = fetchedCrop;
      final image = Flame.images.fromCache(fetchedCrop.seed.icon);
      sprite = Sprite(image);
    }

    if ([CropState.harvested, CropState.dead].contains(crop?.state)) {
      isVisible = true;
    } else {
      isVisible = false;
    }

    super.update(dt);
  }
}
