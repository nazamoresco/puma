import 'package:flutter/widgets.dart';
import 'package:game/classes/seed_bag.dart';

class ThrashWidget extends StatelessWidget {
  final void Function(SeedBag) sell;

  const ThrashWidget({required this.sell, super.key});

  @override
  Widget build(BuildContext context) {
    return DragTarget<SeedBag>(
        onWillAcceptWithDetails: ((details) => true),
        onAcceptWithDetails: (details) => sell(details.data),
        builder: (
          BuildContext context,
          List<SeedBag?> candidateData,
          List<dynamic> rejectedData,
        ) {
          return SizedBox(
            width: 64,
            height: 64,
            child: Image.asset(
              "assets/non_game_images/basura.webp",
            ),
          );
        });
  }
}
