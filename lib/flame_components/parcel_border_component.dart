import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game/classes/crop.dart';
import 'package:game/classes/tile_position.dart';
import 'package:game/flame_components/parcel_component.dart';
import 'package:game/flame_components/puma_game.dart';
import 'package:game/flame_components/rotation_seed_indication_component.dart';

class ParcelBorderComponent extends PositionComponent
    with HasGameRef<PumaGame>, ParentIsA<ParcelComponent>, HasVisibility {
  final TilePosition tilePosition;

  late PolygonComponent border;

  RotationSeedIndicationComponent? seedComponent;

  ParcelBorderComponent(this.tilePosition);

  @override
  FutureOr<void> onLoad() {
    isVisible = game.featureExposure.areCropRotationsExposed;
    border = PolygonComponent.relative(
      [
        Vector2(-1, 0),
        Vector2(0, -1),
        Vector2(1, 0),
        Vector2(0, 1),
      ],
      parentSize: parent.size,
      paint: Paint()
        ..style = PaintingStyle.stroke
        ..color = _calculateColor(_fetchCrop)
        ..strokeWidth = 4,
    );

    add(border);

    seedComponent = RotationSeedIndicationComponent()
      ..anchor = Anchor.center
      ..position = parent.size * .5
      ..size = Vector2(parent.size.x * .25, 0);
      
    add(seedComponent!);

    return super.onLoad();
  }

  Color _calculateColor(Crop? crop) {
    if (crop == null) return Colors.transparent;

    return crop.seed.family.color.withOpacity(
      max(
        crop.calculateProgressToHarvestingState(game.currentDateTime),
        0.5,
      ),
    );
  }

  Crop? get _fetchCrop {
    return game.farm!.crops[tilePosition] ??
        game.farm!.history.latest(tilePosition);
  }

  @override
  void update(double dt) {
    if (game.isOver) return;
    isVisible = game.featureExposure.areCropRotationsExposed;
    border.paint.color = _calculateColor(_fetchCrop);
    super.update(dt);
  }
}
