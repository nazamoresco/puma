import 'package:flame/extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:game/functions/scale_keeping_aspect_ratio.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var backgroundSize = scaleKeepingAspectRatio(
      aspectRatio: Vector2(4684, 3500),
      target: MediaQuery.of(context).size.toVector2(),
    );

    return SizedBox(
      width: backgroundSize.x,
      height: backgroundSize.y,
      child: Image.asset(
        "assets/non_game_images/fondo_completo_sin_nubes.webp",
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
    );
  }
}
