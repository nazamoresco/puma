import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

class CoinCounter extends StatelessWidget {
  final int coins;
  final double? size;

  const CoinCounter({super.key, required this.coins, this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          coins.toString(),
          style: TextStyle(
            decoration: TextDecoration.none,
            color: Colors.black,
            fontFamily: "Crayonara",
            fontWeight: FontWeight.normal,
            fontSize: size,
          ),
        ),
        SizedBox(
          height: size ?? 32,
          child: RawImage(
            image: Flame.images.fromCache("icono_moneda.webp"),
          ),
        )
      ],
    );
  }
}
