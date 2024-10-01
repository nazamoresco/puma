import 'dart:collection';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:game/classes/advice.dart';
import 'package:game/flame_components/advice_component.dart';
import 'package:game/flame_components/puma_game.dart';
import 'package:game/functions/scale_keeping_aspect_ratio.dart';

class AdvisorComponent extends SpriteComponent
    with HasGameRef<PumaGame>, TapCallbacks {
  late Sprite advisorSprite;
  AdviceComponent? currentAdviceComponent;
  AudioPlayer? talkingSound;

  late RectangleComponent background;

  Advice? currentAdvice;
  Queue<Advice> advices = Queue();

  AdvisorComponent(List<Advice> advicesBase) {
    advices.addAll(advicesBase);
  }

  void restart(advicesBase) {
    for (var advice in advicesBase) {
      advice.isHidden = false;
    }

    advices
      ..clear()
      ..addAll(advicesBase);

    analyze();
    assert(currentAdvice != null);
  }

  void shutDown() {
    hideAdvice();
    currentAdvice = null;
  }

  // No se usa mas pero capaz sea util
  void victoryComment(String comment) {
    _hideAdvisor();
    currentAdvice = Advice(text: comment);
    _showAdvisor();
  }

  /// Analizes the game and prompts advices.
  /// It's called by PumaGame every tick.
  void analyze() {
    if (currentAdvice != null) {
      if (currentAdvice!.wasAcknowledged(game)) {
        // If it isn't hidden already hide it.
        if (!currentAdvice!.isHidden) {
          hideAdvice();
        }

        if (currentAdvice!.whenComplete != null) {
          currentAdvice!.whenComplete!(game);
        }

        currentAdvice = null;
        analyze();
      }
      return;
    }

    if (advices.isEmpty) return;
    if (advices.first.isGoodTiming(game)) {
      currentAdvice = advices.removeFirst();

      // Execute callback if present
      if (currentAdvice!.beforeDisplaying != null) {
        currentAdvice!.beforeDisplaying!(game);
      }

      // If it is already acknowledged search the next
      // advice, otherwise show the advice
      if (currentAdvice!.wasAcknowledged(game)) {
        currentAdvice = null;
        analyze();
      } else {
        // Pause time so the player can seed the advice more relaxed
        game.isPaused = true;
        _showAdvisor();
      }
    }
  }

  hideAdvice() {
    game.isPaused = false;
    currentAdvice?.isHidden = true;
    talkingSound?.stop();
    talkingSound = null;

    _hideAdvisor();
  }

  _showAdvisor() {
    size = activeSize;
    FlameAudio.play("espantapajaro.mp3", volume: 0.05).then((value) => talkingSound = value);
    currentAdviceComponent = AdviceComponent(currentAdvice!,
        maxWidth: game.camera.viewport.size.x * 0.7)
      ..anchor = Anchor.bottomLeft
      ..position = Vector2(
        game.camera.viewport.size.x * 0.1,
        game.camera.viewport.size.y * 0.05,
      );

    add(currentAdviceComponent!);

    background.paint.color = Colors.brown.withOpacity(0.5);
    sprite = advisorSprite;
  }

  _hideAdvisor() {
    background.paint.color = Colors.transparent;
    if (currentAdviceComponent == null) return;
    currentAdviceComponent!.removeFromParent();
    currentAdviceComponent = null;
    sprite = null;
    size = Vector2.zero();
  }

  late final Vector2 activeSize;

  @override
  onLoad() {
    anchor = Anchor.bottomLeft;

    background = RectangleComponent(
      size: game.camera.viewport.size * 1.5,
      anchor: Anchor.center,
      paint: Paint()..color = Colors.transparent,
    );

    game.world.add(background);

    final image = Flame.images.fromCache("personaje_512.webp");
    activeSize = scaleKeepingAspectRatio(
      target: Vector2(-1, game.camera.viewport.size.y * 0.4),
      aspectRatio: image.size,
    );

    size = activeSize;
    advisorSprite = Sprite(image);

    // This works under the assumption that starts having an advice to tell
    analyze();
    assert(currentAdvice != null);

    super.onLoad();
  }

  /// It hides the current advice
  @override
  void onTapDown(TapDownEvent event) {
    if (currentAdvice != null) {
      hideAdvice();
    }

    super.onTapDown(event);
  }
}
