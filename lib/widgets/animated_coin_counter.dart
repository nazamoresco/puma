import 'package:flutter/material.dart';
import 'package:game/widgets/coin_counter.dart';

class AnimatedCoinCounter extends StatefulWidget {
  final int coins;
  final double? size;

  const AnimatedCoinCounter({super.key, required this.coins, this.size});

  @override
  State<AnimatedCoinCounter> createState() => _AnimatedCoinCounterState();
}

class _AnimatedCoinCounterState extends State<AnimatedCoinCounter>
    with SingleTickerProviderStateMixin {
  late final AnimationController _coinCounterController = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );

  void _playAnimatedCoinCounterAnimation() {
    _coinCounterController.forward(from: 0.0);
    _coinCounterController.reverse(from: 1.0);
  }

  late final Animation<double> _animation = Tween<double>(
    begin: 1.0,
    end: 1.25,
  ).animate(CurvedAnimation(
    parent: _coinCounterController,
    curve: Curves.easeInOut,
  ));

  @override
  void dispose() {
    _coinCounterController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedCoinCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.coins != oldWidget.coins) {
      _playAnimatedCoinCounterAnimation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: CoinCounter(
                coins: widget.coins,
                size: widget.size,
              ),
            );
          },
        ),
      ],
    );
  }
}
