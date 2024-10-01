// import 'dart:async';

// import 'package:flame/components.dart';
// import 'package:flutter/material.dart';
// import 'package:game/flame_components/puma_game.dart';

// class TotalUsabilityComponent extends PositionComponent
//     with HasGameRef<PumaGame> {
//   final TextPaint textPaint = TextPaint(
//     style: const TextStyle(
//       color: Colors.black,
//       fontSize: 36,
//       fontFamily: "Crayonara",
//     ),
//   );

//   late TextComponent component;

//   @override
//   FutureOr<void> onLoad() {
//     component = TextComponent(
//       text: "Salud ${game.farm!.usability.total}%",
//       textRenderer: textPaint,
//     );

//     size = component.size;
//     add(component);

//     return super.onLoad();
//   }

//   @override
//   void update(double dt) {
//     component.text = "Usabilidad ${(game.farm!.usability.total * 100).truncate()}%";
//     size = component.size;

//     super.update(dt);
//   }
// }
