// import 'dart:math';

// import 'package:flame/components.dart';
// import 'package:game/classes/tile_position.dart';
// import 'package:game/flame_components/puma_game.dart';
// import 'package:flutter/material.dart';
// import 'package:game/flame_components/tile_component.dart';

// class UsabilityBarComponent extends PositionComponent
//     with HasGameRef<PumaGame>, TileComponent {
//   @override
//   final TilePosition tilePosition;
//   final Vector2 barSize;

//   final Paint _barPaint;
//   final Paint _backgroundPaint;

//   double maxValue = 1;
//   double currentValue = 1;
//   // double get usability => game.farm!.usability.get(tilePosition);

//   PolygonComponent? totalRectComponent;
//   PolygonComponent? filledRectComponent;

//   UsabilityBarComponent(
//     this.tilePosition, {
//     required this.barSize,
//     Paint? barPaint,
//     Paint? backgroundPaint,
//   })  : _barPaint = barPaint ?? Paint()
//           ..color = Colors.green,
//         _backgroundPaint = backgroundPaint ?? Paint()
//           ..color = Colors.red,
//         super(
//           anchor: Anchor.bottomCenter,
//           priority: 1500,
//         );

//   @override
//   void update(double dt) {
//     if (usability != currentValue || true) {
//       currentValue = usability;

//       if (currentValue == 1.0) {
//         if (totalRectComponent != null) {
//           remove(totalRectComponent!);
//           totalRectComponent = null;
//         }

//         if (filledRectComponent != null) {
//           remove(filledRectComponent!);
//           filledRectComponent = null;
//         }
//       } else {
//         final offset = Vector2(0.13, -0.8);

//         if (filledRectComponent != null) {
//           remove(filledRectComponent!);
//         }

//         if (totalRectComponent == null) {
//           totalRectComponent = PolygonComponent.relative(
//             [
//               Vector2(-1.0 + .2, -1.0 + .2) + offset,
//               Vector2(1.0, -1.0) + offset,
//               Vector2(1.0 - .2, 1.0 - .2) + offset,
//               Vector2(-1.0, 1.0) + offset,
//             ],
//             parentSize: barSize,
//           )..paint = _backgroundPaint;

//           add(totalRectComponent!);
//         }

//         // Calculate the filled portion
//         final filledRatio = currentValue / maxValue;
//         if (filledRatio != 0.0) {
//           final filledHeight = min<double>(1, (filledRatio - .5) * -2.0);

//           // Adjust the x-coordinate based on the y-scale to maintain the shape
//           // Assuming the original shape's x offset was 0.2 (as seen in the total component),
//           // we scale this offset by the yScale to maintain the proportion as the height changes
//           final xOffsetScale = 0.2 / 2 * filledHeight;

//           filledRectComponent = PolygonComponent.relative(
//             [
//               Vector2(-1.0 + xOffsetScale, filledHeight + .2) + offset,
//               Vector2(1.0 - xOffsetScale, filledHeight) + offset,
//               Vector2(1.0 - .2, 1.0 - .2) + offset,
//               Vector2(-1.0, 1.0) + offset,
//             ],
//             parentSize: barSize,
//           )..paint = _barPaint;

//           add(filledRectComponent!);
//         }
//       }
//     }

//     super.update(dt);
//   }
// }
