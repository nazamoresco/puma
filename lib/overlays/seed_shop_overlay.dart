import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:game/flame_components/puma_game.dart';
import 'package:game/widgets/animated_coin_counter.dart';
import 'package:game/widgets/coin_counter.dart';

class SeedShopOverlay extends StatefulWidget {
  final PumaGame game;

  const SeedShopOverlay(this.game, {super.key});

  onClose() {
    game.isPaused = false;
    game.overlays.remove("seed_shop");
  }

  @override
  State<SeedShopOverlay> createState() => _SeedShopOverlayState();
}

class _SeedShopOverlayState extends State<SeedShopOverlay> {
  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapOutside: (event) {
        widget.onClose();
      },
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .8,
                constraints: const BoxConstraints(
                  minWidth: 850,
                  minHeight: 350,
                  maxWidth: 900,
                ),
                child: RawImage(
                  image: Flame.images.fromCache("COCINA_fondo.webp"),
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(32.0),
                width: MediaQuery.of(context).size.width * .8,
                constraints: const BoxConstraints(
                  minWidth: 850,
                  minHeight: 350,
                  maxWidth: 900,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AnimatedCoinCounter(
                          coins: widget.game.coins,
                          size: 48,
                        ),
                        IconButton(
                          onPressed: widget.onClose,
                          icon: const Icon(
                            Icons.close,
                            color: Colors.brown,
                            size: 32,
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Wrap(
                          direction: Axis.horizontal,
                          runSpacing: 8,
                          children: widget.game.purchasableSeeds.map(
                            (seed) {
                              return SizedBox(
                                height: 200,
                                width: 100,
                                child: GestureDetector(
                                  onTapDown: (_) {
                                    if (widget.game.coins <= 0) {
                                      FlameAudio.play('mistake.mp3', volume: .05);
                                      return;
                                    }
                                    widget.game.coins -= 1;
                                    widget.game.dispenser?.stock(seed);
                                    FlameAudio.play('item_purchase.wav', volume: .05);
                                    setState(() {});
                                  },
                                  child: Column(
                                    children: [
                                      RawImage(
                                        image:
                                            Flame.images.fromCache(seed.icon),
                                      ),
                                      Text(
                                        seed.name,
                                        style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          color: Colors.black,
                                          fontFamily: "Crayonara",
                                          fontWeight: FontWeight.normal,
                                          fontSize: 24,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          if (widget.game.featureExposure
                                              .areSeasonsExposed)
                                            ...seed.seasons.map((season) {
                                              return SizedBox(
                                                width: 24,
                                                height: 24,
                                                child: RawImage(
                                                  image: Flame.images.fromCache(
                                                    season.imagePath,
                                                  ),
                                                ),
                                              );
                                            }),
                                          const CoinCounter(
                                            coins: 1,
                                            size: 24,
                                          ),
                                          if (widget.game.dispenser
                                                  ?.getBag(seed) !=
                                              null)
                                            Text(
                                              "(${widget.game.dispenser?.getBag(seed)!.count})",
                                              style: const TextStyle(
                                                decoration: TextDecoration.none,
                                                color: Colors.black,
                                                fontFamily: "Crayonara",
                                                fontWeight: FontWeight.normal,
                                                fontSize: 24,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
