// import 'package:flame/components.dart';
// import 'package:flame/events.dart';
// import 'package:flame/flame.dart';
// import 'package:game/classes/farm.dart';
// import 'package:game/classes/tile_position.dart';
// import 'package:game/flame_components/puma_game.dart';
// import 'package:game/flame_components/usability_component.dart';

// class UsabilityButton extends SpriteComponent
//     with HasGameRef<PumaGame>, TapCallbacks {
//   List<UsabilityComponent> components = [];

//   @override
//   onLoad() {
//     sprite = Sprite(Flame.images.fromCache("heart.webp"));
//   }

//   removeUsabilityOverlay() {
//     game.world.removeAll(components);
//     components = [];
//   }

//   addUsabilityOverlay() {
//     for (var colIndex = 0; colIndex < Farm.parcelsCount.width; colIndex++) {
//       for (var rowIndex = 0; rowIndex < Farm.parcelsCount.height; rowIndex++) {
//         final component = UsabilityComponent(TilePosition(colIndex, rowIndex));
//         components.add(component);
//         game.world.add(component);
//       }
//     }
//   }

//   @override
//   void onTapDown(TapDownEvent event) {
//     if (components.isEmpty) {
//       addUsabilityOverlay();
//     } else {
//       removeUsabilityOverlay();
//     }

//     super.onTapDown(event);
//   }
// }
