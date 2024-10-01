import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:game/classes/level_configuration.dart';
import 'package:game/flame_components/puma_game.dart';
import 'package:game/widgets/music_controls.dart';

class MenuOverlay extends StatelessWidget {
  final PumaGame game;
  final void Function() onGameEnd;

  const MenuOverlay(this.game, {super.key, required this.onGameEnd});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .5,
            height: MediaQuery.of(context).size.height * .8,
            constraints: const BoxConstraints(
              minWidth: 850,
              minHeight: 100,
              maxWidth: 900,
              maxHeight: 600,
            ),
            child: RawImage(
              image: Flame.images.fromCache("COCINA_fondo.webp"),
              fit: BoxFit.fill,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .5,
            height: MediaQuery.of(context).size.height * .8,
            constraints: const BoxConstraints(
              minWidth: 850,
              minHeight: 100,
              maxWidth: 900,
              maxHeight: 600,
            ),
            padding: const EdgeInsets.all(32.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    const Text(
                      "Menu",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontFamily: "Crayonara",
                        fontWeight: FontWeight.normal,
                        fontSize: 32,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 246, 104, 52),
                        padding: const EdgeInsets.all(16),
                      ),
                      onPressed: () {
                        game.overlays.add("tutorial");
                      },
                      child: const Text(
                        "Tutorial / Ayuda",
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontFamily: "Crayonara",
                          fontWeight: FontWeight.normal,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    MusicControls(game: game),
                    const SizedBox(height: 8),
                    const Text(
                      "Objetivos",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontFamily: "Crayonara",
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: Checkbox(
                            value: game.coins >= 50,
                            onChanged: null,
                          ),
                        ),
                        const Text(
                          "Haz 50 monedas",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontFamily: "Crayonara",
                            fontWeight: FontWeight.normal,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: Checkbox(
                            value:
                                (game.cookbook?.lockedRecipes.isEmpty ?? false),
                            onChanged: null,
                          ),
                        ),
                        const Text(
                          "Desbloquea todas las recetas",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontFamily: "Crayonara",
                            fontWeight: FontWeight.normal,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            game.finishGame();
                            if (game.levelConfiguration ==
                                LevelConfiguration.level4) {
                              onGameEnd();
                            } else {
                              game.nextLevel();
                            }
                          },
                          child: Text("Siguiente Nivel"),
                        ),
                        TextButton(
                          onPressed: () {
                            onGameEnd();
                          },
                          child: Text("Ir a cuestionario"),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 246, 104, 52),
                        padding: const EdgeInsets.all(16),
                      ),
                      onPressed: () {
                        game.restartGame();
                        Navigator.of(context).pushNamed("/home");
                      },
                      child: const Text(
                        "Menu principal",
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontFamily: "Crayonara",
                          fontWeight: FontWeight.normal,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      game.overlays.remove("menu");
                      game.isPaused = false;
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.brown,
                      size: 32,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
