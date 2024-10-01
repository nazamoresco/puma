import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:game/functions/scale_keeping_aspect_ratio.dart';
import 'package:game/widgets/background_widget.dart';
import 'package:game/widgets/level_selector.dart';
import 'package:game/widgets/moving_clouds.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine if we should use mobile layout or not, 600 here is
    // a common breakpoint for a typical 7-inch tablet.
    final isMobile = MediaQuery.of(context).size.shortestSide < 600;

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
                        "puma",
                        style: TextStyle(
                          fontFamily: "Crayonara",
                          color: Colors.brown,
                          fontSize: 84,
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
                            title: "Juego",
                            isMobile: isMobile,
                            moveToLevel: () {
                              Navigator.of(context).pushNamed("/game");
                            },
                          ),
                        ],
                      ),
                    ),
                    // Flexible(
                    //   flex: 4,
                    //   child: ListView(
                    //     children: [
                    //       LevelSelector(
                    //         title: "Para Tecnicatura en Agricultura",
                    //         isMobile: isMobile,
                    //         moveToLevel: () {
                    //           Navigator.of(context)
                    //               .pushNamed("/tecnicatura_en_agricultura");
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Flexible(
                    //   flex: 4,
                    //   child: ListView(
                    //     children: [
                    //       LevelSelector(
                    //         title: "Para PPS",
                    //         isMobile: isMobile,
                    //         moveToLevel: () {
                    //           Navigator.of(context).pushNamed("/pps");
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
