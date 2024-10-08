import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:game/classes/seed.dart';
import 'package:game/classes/seed_bag.dart';
import 'package:game/functions/is_phone.dart';

class IngredientSlot extends StatelessWidget {
  final int index;
  final Seed? seed;
  final void Function(int index, SeedBag seedBag) placeIngredient;
  final void Function(int index) onTap;

  final Color? borderColor;

  const IngredientSlot(
    this.index, {
    super.key,
    required this.placeIngredient,
    required this.seed,
    required this.onTap,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isPhoneVar = isPhone(screenSize);

    return DragTarget<SeedBag>(
      onWillAcceptWithDetails: ((details) => true),
      onAcceptWithDetails: (details) => placeIngredient(index, details.data),
      builder: (
        BuildContext context,
        List<SeedBag?> candidateData,
        List<dynamic> rejectedData,
      ) {
        final placedSeed =
            candidateData.isEmpty ? seed : candidateData.first!.seed;

        return GestureDetector(
          onTapDown: (_) => onTap(index),
          child: Container(
            constraints: BoxConstraints.tight(isPhoneVar ? 
            const Size(50, 50) : const Size(100, 100)),
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: const AssetImage(
                  "assets/images/COCINA_cuadrado_rojo.webp",
                ),
                fit: BoxFit.fill,
                colorFilter: borderColor != null
                    ? ColorFilter.mode(
                        borderColor!,
                        BlendMode.srcIn,
                      )
                    : null,
              ),
            ),
            child: placedSeed != null
                ? Container(
                    padding: const EdgeInsets.all(8),
                    child: RawImage(
                      fit: BoxFit.fill,
                      image: Flame.images.fromCache(
                        placedSeed.icon,
                      ),
                    ),
                  )
                : null,
          ),
        );
      },
    );
  }
}
