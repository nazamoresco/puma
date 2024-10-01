import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:game/flame_components/puma_game.dart';
import 'package:game/widgets/frog_comment_widget.dart';

class FrogWidget extends StatelessWidget {
  final PumaGame game;

  const FrogWidget(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FrogCommentWidget(game),
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              height: 100,
              child: RawImage(
                image: Flame.images.fromCache(
                  "COCINA_fondo_sapo.webp",
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              height: 100,
              child: RawImage(
                image: Flame.images.fromCache(
                  "sapo_512_1.webp",
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}