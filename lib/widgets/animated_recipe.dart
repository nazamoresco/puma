import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:game/classes/recipe.dart';

class AnimatedRecipe extends StatefulWidget {
  const AnimatedRecipe({
    super.key,
    required this.recipeResult,
    required this.onComplete,
  });

  final Recipe? recipeResult;
  final void Function() onComplete;

  @override
  State<AnimatedRecipe> createState() => _AnimatedRecipeState();
}

class _AnimatedRecipeState extends State<AnimatedRecipe>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  )
    ..forward(from: 0.0)
    ..addListener(() {
      if (_controller.isCompleted) {
        widget.onComplete();
      }
    });

  late final Animation<Offset> _animation = Tween<Offset>(
    begin: const Offset(0, 0),
    end: const Offset(0, -1),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: RawImage(
        image: Flame.images.fromCache(
          widget.recipeResult!.imagePath,
        ),
      ),
    );
  }
}
