import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game/classes/level_configuration.dart';
import 'package:game/flame_components/puma_game.dart';
import 'package:game/overlays/kitchen_overlay.dart';
import 'package:game/overlays/menu_overlay.dart';
import 'package:game/overlays/seed_shop_overlay.dart';
import 'package:game/overlays/tutorial_overlay.dart';
import 'package:game/overlays/victory_overlay.dart';
import 'package:game/widgets/agroecologia_questionaire.dart';
import 'package:game/widgets/background_widget.dart';
import 'package:game/widgets/moving_clouds.dart';
import 'package:gsheets/gsheets.dart';

// Delete in google console after tests.
const credentials = {};
const spreadsheetId = "";

class UniversityTestScreen extends StatefulWidget {
  const UniversityTestScreen({super.key});

  @override
  State<UniversityTestScreen> createState() => _UniversityTestScreenState();
}

class _UniversityTestScreenState extends State<UniversityTestScreen> {
  Worksheet? sheet;
  Map<int, String> responses = {};

  bool startingQuestionarie = false;
  bool finishingQuestionarie = false;

  final userId = Random().nextInt(1000000);

  uploadResponses() {
    final gsheets = GSheets(credentials);
    gsheets.spreadsheet(spreadsheetId).then((ss) async {
      sheet = ss.worksheetByTitle('Agro')!;

      for (int i = 0; i < responses.keys.max; i++) {
        responses.putIfAbsent(i, () => "[not answered]");
      }

      responses[99] = "[Agroecologia $userId]";

      await sheet!.values.appendRow(
        responses.values.toList(),
      );
    });
  }

  void uploadLevel(levelConfiguration) {
    final gsheets = GSheets(credentials);
    gsheets.spreadsheet(spreadsheetId).then((ss) async {
      sheet = ss.worksheetByTitle('Agro')!;

      if (levelConfiguration == LevelConfiguration.level1) {
        await sheet!.values.appendRow(["Nivel 1 superado $userId"]);
      } else if (levelConfiguration == LevelConfiguration.level2) {
        await sheet!.values.appendRow(["Nivel 2 superado $userId"]);
      } else if (levelConfiguration == LevelConfiguration.level3) {
        await sheet!.values.appendRow(["Nivel 3 superado $userId"]);
      } else if (levelConfiguration == LevelConfiguration.level4) {
        await sheet!.values.appendRow(["Nivel 4 superado $userId"]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          const BackgroundWidget(),
          const Text(
            "puma",
            style: TextStyle(
              fontFamily: "Crayonara",
              color: Colors.brown,
              fontSize: 84,
              fontWeight: FontWeight.bold,
            ),
          ),
          const MovingClouds(),
          if (finishingQuestionarie)
            AgroecologiaQuestionarie(
              getResponse: (index) => responses[index],
              setResponse: (int index, String answer) {
                setState(() {
                  responses[index] = answer;
                });
              },
              onClose: () {
                uploadResponses();
                Navigator.of(context).pushNamed("/thanks");
              },
            ),
          if (!finishingQuestionarie && !startingQuestionarie)
            Align(
              alignment: Alignment.bottomCenter,
              child: GameWidget(
                game: PumaGame(
                  levelConfiguration: LevelConfiguration.level1,
                  safeAreaPadding: const EdgeInsets.all(16),
                  areAssetsCached: false,
                  onAssetsCached: () {},
                  goToQuestionaire: () {
                    setState(() {
                      finishingQuestionarie = true;
                    });
                  },
                ),
                overlayBuilderMap: {
                  "kitchen": (context, PumaGame game) => KitchenOverlay(game),
                  "seed_shop": (context, PumaGame game) =>
                      SeedShopOverlay(game),
                  "tutorial": (context, PumaGame game) => TutorialOverlay(game),
                  "menu": (context, PumaGame game) => MenuOverlay(
                        game,
                        onGameEnd: () {
                          setState(() {
                            finishingQuestionarie = true;
                          });
                        },
                      ),
                  "victory": (context, PumaGame game) => VictoryOverlay(
                        game,
                        onGameEnd: () {
                          uploadLevel(LevelConfiguration.level4);
                          setState(() {
                            finishingQuestionarie = true;
                          });
                        },
                        onNextLevel: (levelConfiguration) {
                          uploadLevel(levelConfiguration);
                        },
                      ),
                },
              ),
            )
        ],
      ),
    );
  }
}
