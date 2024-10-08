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
import 'package:game/widgets/background_widget.dart';
import 'package:game/widgets/moving_clouds.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
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
          Align(
            alignment: Alignment.bottomCenter,
            child: GameWidget(
              game: PumaGame(
                levelConfiguration: LevelConfiguration.level1,
                safeAreaPadding: const EdgeInsets.all(16),
                areAssetsCached: false,
                onAssetsCached: () {},
              ),
              overlayBuilderMap: {
                "kitchen": (context, PumaGame game) => KitchenOverlay(game),
                "seed_shop": (context, PumaGame game) => SeedShopOverlay(game),
                "tutorial": (context, PumaGame game) => TutorialOverlay(game),
                "menu": (context, PumaGame game) => MenuOverlay(
                      game,
                      onGameEnd: () {
                        Navigator.of(context).pushNamed("/thanks");
                      },
                    ),
                "victory": (context, PumaGame game) => VictoryOverlay(
                      game,
                      onGameEnd: () {
                        Navigator.of(context).pushNamed("/thanks");
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
