import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:game/classes/recipe.dart';
import 'package:game/classes/seed.dart';
import 'package:game/classes/seed_bag.dart';
import 'package:game/flame_components/puma_game.dart';
import 'package:game/functions/is_phone.dart';
import 'package:game/widgets/animated_coin_counter.dart';
import 'package:game/widgets/animated_recipe.dart';
import 'package:game/widgets/frog_widget.dart';
import 'package:game/widgets/ingredient_slot.dart';
import 'package:game/widgets/recipe_widget.dart';
import 'package:game/widgets/thrash_widget.dart';

class KitchenOverlay extends StatefulWidget {
  final PumaGame game;

  const KitchenOverlay(this.game, {super.key});

  @override
  State<KitchenOverlay> createState() => _KitchenOverlayState();
}

class _KitchenOverlayState extends State<KitchenOverlay> {
  final Map<int, Seed> ingredients = {};
  final Map<int, Color?> slotColor = {};
  Recipe? recipeResult;

  // Re-stock if the ingredient
  void restock(index) {
    widget.game.dispenser?.harvest(ingredients[index]!);
  }

  void removeIngredient(int index) {
    FlameAudio.play('cooking.mp3', volume: .05);
    restock(index);

    setState(() {
      ingredients.remove(index);
      slotColor.remove(index);
    });
  }

  void placeIngredient(int index, SeedBag seedBag) {
    FlameAudio.play('cooking.mp3', volume: .05);

    // Restart the crafting method
    if (recipeResult != null) {
      setState(() => recipeResult = null);
    }

    // Re-stock if the ingredient was already set before placing the new one
    if (ingredients[index] != null) {
      removeIngredient(index);
    }

    // Place the ingredient
    widget.game.dispenser?.removeFromHarvest(seedBag.seed);

    setState(() {
      ingredients[index] = seedBag.seed;
    });

    recalculateSlotsColors();

    // If 3 ingredients check for recipe
    if (ingredients.values.length == 3) {
      final recipe = widget.game.cookbook?.combine(ingredients.values.toList());

      // If no result recipe, return.
      if (recipe == null) {
        return;
      }

      // If not unlock, unlock recipe.
      if (!(widget.game.cookbook?.unlockedRecipes.contains(recipe) ?? true)) {
        FlameAudio.play('recipe_unlock.wav', volume: .05);
        widget.game.cookbook?.unlockedRecipes.add(recipe);
      } else {
        FlameAudio.play('recipe_sold.wav', volume: .05);
      }

      // Add the coins earn for the dish.
      widget.game.coins += 10;
      widget.game.producedPlates[recipe] =
          (widget.game.producedPlates[recipe] ?? 0) + 1;

      setState(() {
        recipeResult = recipe;
        ingredients.clear();
        slotColor.clear();
      });
    }
  }

  void handleIngredientSlotTap(int index) {
    if (ingredients[index] != null) {
      removeIngredient(index);
    }

    recalculateSlotsColors();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isPhoneVar = isPhone(screenSize);
    return TapRegion(
      onTapOutside: (event) {
        for (var index in ingredients.keys) {
          restock(index);
        }

        widget.game.isPaused = false;
        widget.game.overlays.remove("kitchen");
      },
      child: Padding(
        padding: isPhoneVar
            ? const EdgeInsets.all(16.0)
            : const EdgeInsets.all(32.0),
        child: Center(
          child: Stack(
            children: [
              Container(
                width: isPhoneVar
                    ? MediaQuery.of(context).size.width * .9
                    : MediaQuery.of(context).size.width * .8,
                constraints: BoxConstraints(
                  minWidth: 850,
                  minHeight: 350,
                  maxWidth: isPhoneVar ? 1500 : 900,
                ),
                child: RawImage(
                  image: Flame.images.fromCache("COCINA_fondo.webp"),
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                width: isPhoneVar
                    ? MediaQuery.of(context).size.width * .9
                    : MediaQuery.of(context).size.width * .8,
                constraints: BoxConstraints(
                  minWidth: 850,
                  minHeight: 350,
                  maxWidth: isPhoneVar ? 1500 : 900,
                ),
                padding: isPhoneVar
                    ? const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 24.0)
                    : const EdgeInsets.all(32.0),
                child: Row(
                  children: [
                    Flexible(
                      flex: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AnimatedCoinCounter(
                                coins: widget.game.coins,
                                size: 32,
                              ),
                              FrogWidget(widget.game),
                            ],
                          ),
                          Container(
                            constraints: BoxConstraints(
                              minHeight: isPhoneVar ? 50 : 100,
                            ),
                            child: Row(
                              children: [
                                IngredientSlot(
                                  0,
                                  seed: ingredients[0],
                                  borderColor: slotColor[0],
                                  placeIngredient: placeIngredient,
                                  onTap: handleIngredientSlotTap,
                                ),
                                isPhoneVar
                                    ? const SizedBox(width: 8)
                                    : const SizedBox(width: 16),
                                IngredientSlot(
                                  1,
                                  seed: ingredients[1],
                                  borderColor: slotColor[1],
                                  placeIngredient: placeIngredient,
                                  onTap: handleIngredientSlotTap,
                                ),
                                isPhoneVar
                                    ? const SizedBox(width: 8)
                                    : const SizedBox(width: 16),
                                IngredientSlot(
                                  2,
                                  seed: ingredients[2],
                                  borderColor: slotColor[2],
                                  placeIngredient: placeIngredient,
                                  onTap: handleIngredientSlotTap,
                                ),
                                isPhoneVar
                                    ? const SizedBox(width: 4)
                                    : const SizedBox(width: 8),
                                Container(
                                  width: isPhoneVar ? 16 : 32,
                                  height: isPhoneVar ? 16 : 32,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/COCINA_flecha_roja.webp",
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                isPhoneVar
                                    ? const SizedBox(width: 4)
                                    : const SizedBox(width: 8),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.height * .25,
                                  height:
                                      MediaQuery.of(context).size.height * .25,
                                  constraints: BoxConstraints.tight(
                                    isPhoneVar
                                        ? const Size(50, 50)
                                        : const Size(100, 100),
                                  ),
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/COCINA_cuadrado_rojo.webp",
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: recipeResult != null
                                      ? AnimatedRecipe(
                                          recipeResult: recipeResult,
                                          onComplete: () {
                                            setState(() {
                                              widget.game.frog.talk(
                                                recipeResult,
                                              );
                                              recipeResult = null;
                                            });
                                          })
                                      : null,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Ingredientes",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: "Crayonara",
                              color: Colors.brown,
                              fontSize: isPhoneVar ? 16 : 24,
                            ),
                          ),
                          (widget.game.dispenser?.harvests ?? []).isNotEmpty
                              ? SingleChildScrollView(
                                  child: Wrap(
                                    direction: Axis.horizontal,
                                    runSpacing: 8,
                                    children: widget.game.dispenser!.harvests
                                        .map<Widget>(
                                      (seedBag) {
                                        return Draggable<SeedBag>(
                                          data: seedBag,
                                          feedback: SizedBox(
                                            width: 100,
                                            height: 100,
                                            child: RawImage(
                                              image: Flame.images.fromCache(
                                                seedBag.seed.icon,
                                              ),
                                            ),
                                          ),
                                          child: GestureDetector(
                                            onTapDown: (_) {
                                              final remainingKeys = {0, 1, 2}
                                                  .difference(
                                                      ingredients.keys.toSet());
                                              if (remainingKeys.isEmpty) return;
                                              placeIngredient(
                                                remainingKeys.first,
                                                seedBag,
                                              );
                                            },
                                            child: SizedBox(
                                              height: isPhoneVar ? 50 : 100,
                                              width: isPhoneVar ? 50 : 100,
                                              child: Stack(
                                                alignment:
                                                    Alignment.bottomRight,
                                                children: [
                                                  RawImage(
                                                    image:
                                                        Flame.images.fromCache(
                                                      seedBag.seed.icon,
                                                    ),
                                                  ),
                                                  Text(
                                                    "x${seedBag.count}",
                                                    textAlign: TextAlign.right,
                                                    style: const TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontFamily: "Crayonara",
                                                      color: Colors.brown,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList()
                                      ..add(
                                        Align(
                                            alignment: Alignment.bottomCenter,
                                            child: ThrashWidget(
                                              sell: (seedBag) {
                                                widget.game.dispenser
                                                    ?.removeFromHarvest(
                                                        seedBag.seed);
                                                widget.game.coins += 1;
                                                setState(() {});
                                              },
                                            )),
                                      ),
                                  ),
                                )
                              : Text(
                                  "No hay mas ingredientes! Planta y cosecha mas cultivos para continuar.",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: "Crayonara",
                                    color: Colors.brown,
                                    fontSize: isPhoneVar ? 16 : 20,
                                  ),
                                )
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "Platos a desbloquear",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontFamily: "Crayonara",
                                    color: Colors.brown,
                                    fontSize: isPhoneVar ? 16 : 24,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  widget.game.isPaused = false;
                                  widget.game.overlays.remove("kitchen");
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.brown,
                                  size: isPhoneVar ? 16 : 32,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              children:
                                  widget.game.cookbook?.unlockableRecipes.map(
                                        (recipe) {
                                          return SizedBox(
                                            width: isPhoneVar ? 50 : 100,
                                            height: isPhoneVar ? 50 : 100,
                                            child: RecipeWidget(
                                              recipe,
                                              isUnlocked: widget.game.cookbook
                                                      ?.unlockedRecipes
                                                      .contains(recipe) ??
                                                  false,
                                              frogPays: widget
                                                  .game.frog.recipePay[recipe],
                                            ),
                                          );
                                        },
                                      ).toList() ??
                                      [],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void recalculateSlotsColors() {
    setState(() {
      for (var slotIndex in ingredients.keys) {
        slotColor[slotIndex] = widget.game.cookbook?.goodPathToLockedRecipe(
          ingredients.values.toList(),
          widget.game.dispenser!,
        )
            ? Colors.green
            : widget.game.cookbook?.goodPathToUnlockedRecipe(
                ingredients.values.toList(),
                widget.game.dispenser!,
              )
                ? Colors.blue
                : null;
      }
    });
  }
}
