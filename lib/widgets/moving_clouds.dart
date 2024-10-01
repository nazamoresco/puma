import 'package:flutter/material.dart';

class MovingClouds extends StatefulWidget {
  const MovingClouds({
    super.key,
  });

  @override
  State<MovingClouds> createState() => _MovingCloudsState();
}

class _MovingCloudsState extends State<MovingClouds>
    with TickerProviderStateMixin {
  static const Duration duration = Duration(seconds: 40);

  late final AnimationController _firstController = AnimationController(
    duration: duration,
    vsync: this,
  )
    ..forward(from: 0.5)
    ..repeat();

  late final Animation<Offset> _firstOffsetAnimation = Tween<Offset>(
    begin: const Offset(-1, 0),
    end: const Offset(1, 0.0),
  ).animate(CurvedAnimation(
    parent: _firstController,
    curve: Curves.linear,
  ));

  late final AnimationController _secondController = AnimationController(
    duration: duration,
    vsync: this,
  )..repeat();

  late final Animation<Offset> _secondOffsetAnimation = Tween<Offset>(
    begin: const Offset(-1, 0),
    end: const Offset(1, 0.0),
  ).animate(CurvedAnimation(
    parent: _secondController,
    curve: Curves.linear,
  ));

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SlideTransition(
          position: _firstOffsetAnimation,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/non_game_images/nubes_panoramica.webp",
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
        SlideTransition(
          position: _secondOffsetAnimation,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/non_game_images/nubes_panoramica.webp",
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
      ],
    );
  }
}
