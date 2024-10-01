import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:game/classes/level_configuration.dart';
import 'package:game/flame_components/puma_game.dart';
import 'package:game/widgets/result_recipe_widget.dart';

class VictoryOverlay extends StatefulWidget {
  final PumaGame game;
  final void Function() onGameEnd;
  final void Function(LevelConfiguration)? onNextLevel;

  const VictoryOverlay(
    this.game, {
    super.key,
    required this.onGameEnd,
    this.onNextLevel,
  });

  @override
  State<VictoryOverlay> createState() => _VictoryOverlayState();
}

class _VictoryOverlayState extends State<VictoryOverlay> {
  @override
  void initState() {
    FlameAudio.play('level_win.mp3', volume: .05);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(32.0),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/COCINA_fondo.webp"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Column(
                children: [
                  Text(
                    'Bien hecho!', // Use the name property of PumaGame
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown, // Customize the text color as needed
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '¡Tu dedicación y esfuerzo han\n dado sus frutos, literalmente!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.normal,
                      color: Colors.brown,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 1000,
                ),
                child: Wrap(
                  direction: Axis.horizontal,
                  children: widget.game.producedPlates.entries
                      .map(
                        (entry) => SizedBox(
                          height: 100,
                          width: 250,
                          child: ResultRecipeWidget(
                            entry.key,
                            amount: entry.value,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (widget.game.levelConfiguration ==
                      LevelConfiguration.level4) {
                    widget.onGameEnd();
                  } else {
                    if (widget.onNextLevel != null) {
                      widget.onNextLevel!(widget.game.levelConfiguration);
                    }
                    widget.game.nextLevel();
                  }

                  widget.game.overlays.remove("victory");
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.brown.withOpacity(0.8),
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    "Siguiente nivel!",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.grey.shade300,
                      fontFamily: "Crayonara",
                      fontWeight: FontWeight.normal,
                      fontSize: 32,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
