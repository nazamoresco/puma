import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:game/classes/farm.dart';
import 'package:game/classes/tile_position.dart';
import 'package:game/flame_components/crop_component.dart';
import 'package:game/flame_components/parcel_border_component.dart';
import 'package:game/flame_components/puma_game.dart';
import 'package:game/flame_components/tile_component.dart';

class ParcelComponent extends SpriteComponent
    with HasGameRef<PumaGame>, TapCallbacks, TileComponent {
  @override
  final TilePosition tilePosition;

  ParcelComponent({required this.tilePosition});

  late ParcelBorderComponent border;

  bool isDisplayingUsable = true;

  CropComponent? cropComponent;

  @override
  onLoad() async {
    super.onLoad();
    anchor = Anchor.center;
    sprite = Sprite(Flame.images.fromCache("0_tierra_pelada.webp"));
    border = ParcelBorderComponent(tilePosition);
    add(border);
  }

  @override
  void update(double dt) {
    if (game.isOver) return;

    final isUsable = game.farm!.usability.isUsable(tilePosition);
    if (isUsable && !isDisplayingUsable) {
      isDisplayingUsable = true;
      sprite = Sprite(Flame.images.fromCache("0_tierra_pelada.webp"));
      add(border);
    } else if (!isUsable && isDisplayingUsable) {
      isDisplayingUsable = false;
      sprite = Sprite(Flame.images.fromCache("3_tierra_muerta.webp"));
      remove(border);
    }

    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    final result = game.farm!.handleTap(
      tilePosition,
      selectedSeed: game.selectedSeed,
      currentDateTime: game.currentDateTime,
      featureExposure: game.featureExposure,
    );

    switch (result.type) {
      case TapResults.none:
        game.touch.start(volume: 0.05);
        break;
      case TapResults.addCrop:
        game.seedPlanting.start(volume: 0.05);

        // NM: When planting a seed, remove one from the dispenser.
        for (var seedBag in game.dispenser!.seedBags) {
          if (seedBag.seed == result.crop!.seed) {
            seedBag.count -= 1;
          }

          if (seedBag.count == 0) {
            game.dispenser!.removeSeedBag(seedBag.seed);
            if (seedBag.seed == game.selectedSeed) {
              game.selectedSeed = null;
            }
          }
        }

        cropComponent = CropComponent(result.crop!);
        game.world.add(cropComponent!);
        if (game.featureExposure.areCropRotationsExposed) {
          if (result.rotated) {
            game.world.add(
              AnimatedTextComponent("Buena rotacion!")
                ..anchor = Anchor.topCenter
                ..position = Vector2(position.x, position.y - size.y),
            );
          }

          if (game.featureExposure.arePlaguesExposed && result.isNewSeed) {
            Future.delayed(Duration(milliseconds: result.rotated ? 1000 : 0),
                () {
              game.world.add(
                AnimatedTextComponent("Diversidad de cultivos!")
                  ..anchor = Anchor.topCenter
                  ..position = Vector2(position.x, position.y - size.y),
              );
            });
          }
        }

        break;
      case TapResults.removeCrop:
        cropComponent?.onCropRemoved(result.crop!);
        break;
      case TapResults.deadParcel:
        game.world.add(
          AnimatedTextComponent("Cultivo repetido :(")
            ..anchor = Anchor.topCenter
            ..position = Vector2(position.x, position.y - size.y),
        );
        FlameAudio.play("sad-noise.wav", volume: 0.05);
        break;
      default:
        break;
    }

    /// Effect
    switch (result.type) {
      case TapResults.none:
      case TapResults.addCrop:
        add(SizeEffect.to(
          size * 1.05,
          EffectController(
              duration: 0.2, curve: Curves.linear, alternate: true),
        ));
        break;
      case TapResults.deadParcel:
        break;
      default:
        break;
    }

    super.onTapDown(event);
  }
}

class AnimatedTextComponent extends TextComponent with HasPaint {
  AnimatedTextComponent(String text)
      : super(
          text: text,
          textRenderer: TextPaint(
            style: const TextStyle(
              fontFamily: "Crayonara",
              fontWeight: FontWeight.normal,
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          priority: 10000,
        );

  @override
  FutureOr<void> onLoad() {
    add(
      MoveByEffect(
        Vector2(0, -10),
        EffectController(
          duration: 0.5,
          curve: Curves.fastEaseInToSlowEaseOut,
          reverseDuration: 0.5,
          reverseCurve: Curves.fastEaseInToSlowEaseOut,
        ),
        onComplete: removeFromParent,
      ),
    );

    add(ScaleEffect.to(
      Vector2.all(1.5),
      EffectController(
        duration: .5,
        curve: Curves.linearToEaseOut,
      ),
    ));

    return super.onLoad();
  }
}
