import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:game/classes/recipe.dart';

class ResultRecipeWidget extends StatelessWidget {
  const ResultRecipeWidget(
    this.recipe, {
    super.key,
    required this.amount,
  });

  final Recipe recipe;
  final int? amount;

  @override
  Widget build(BuildContext context) {
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
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                "$amount platos armados",
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: "Crayonara",
                  color: Colors.black,
                  fontSize: 18,
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
          ],
        ),
      ],
    );
  }
}
