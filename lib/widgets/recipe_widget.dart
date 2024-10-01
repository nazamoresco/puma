import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:game/classes/recipe.dart';
import 'package:game/widgets/animated_coin_counter.dart';

class RecipeWidget extends StatelessWidget {
  const RecipeWidget(
    this.recipe, {
    super.key,
    required this.isUnlocked,
    required this.frogPays,
  });

  final Recipe recipe;
  final bool isUnlocked;
  final int? frogPays;

  @override
  Widget build(BuildContext context) {
    if (!isUnlocked) {
      return Align(
        alignment: Alignment.centerLeft,
        child: RawImage(
          color: Colors.deepOrange,
          image: Flame.images.fromCache(
            recipe.imagePath,
          ),
        ),
      );
    }

    return Row(
      children: [
        RawImage(
          image: Flame.images.fromCache(
            recipe.imagePath,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * .1,
              ),
              child: Text(
                recipe.name,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: "Crayonara",
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: recipe.seeds
                  .map(
                    (seed) => SizedBox(
                      height: 25,
                      child: RawImage(
                        image: Flame.images.fromCache(seed.icon),
                      ),
                    ),
                  )
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: AnimatedCoinCounter(
                coins: frogPays ?? 0,
                size: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
