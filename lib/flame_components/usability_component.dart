// import 'package:flame/components.dart';
// import 'package:game/classes/tile_position.dart';
// import 'package:game/flame_components/puma_game.dart';
// import 'package:game/flame_components/tile_component.dart';

// class UsabilityComponent extends TextComponent
//     with HasGameRef<PumaGame>, TileComponent {
//   @override
//   final TilePosition tilePosition;

//   UsabilityComponent(this.tilePosition);

//   double get usability => game.farm!.usability.get(tilePosition);
//   String get usabilityString => "${(usability * 100).ceil()}%";

//   @override
//   onLoad() async {
//     super.onLoad();

//     anchor = Anchor.center;
//     text = usabilityString;
//   }

//   @override
//   void update(double dt) {
//     text = usabilityString;
//     super.update(dt);
//   }
// }
