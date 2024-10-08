import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:game/functions/scale_keeping_aspect_ratio.dart';
import 'package:game/widgets/background_widget.dart';
import 'package:game/widgets/level_selector.dart';
import 'package:game/widgets/moving_clouds.dart';

class ThanksScreen extends StatelessWidget {
  const ThanksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final advisorSize = scaleKeepingAspectRatio(
      aspectRatio: Vector2(1200, 950),
      target: Vector2(
        MediaQuery.of(context).size.width * .4,
        MediaQuery.of(context).size.height * .4,
      ),
    );

    return Stack(
      children: [
        const BackgroundWidget(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 64,
                    ),
                    width: advisorSize.x,
                    height: advisorSize.y,
                    child: Image.asset(
                      "assets/images/personaje_grande.webp",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                      flex: 8,
                      child: Text(
                        "Gracias por jugar PUMA :)",
                        style: TextStyle(
                          fontFamily: "Crayonara",
                          color: Colors.brown,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Flexible(
                      flex: 4,
                      child: ListView(
                        children: [
                          LevelSelector(
                            title: "Menu",
                            isMobile: false,
                            moveToLevel: () {
                              Navigator.of(context).pushNamed("/home");
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const MovingClouds(),
      ],
    );
  }
}
