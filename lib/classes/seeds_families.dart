import 'package:flutter/material.dart';

class SeedFamily {
  final Color color;

  const SeedFamily({required this.color});

  static const apiaceae = SeedFamily(color: Colors.orange);
  static const asteraceae = SeedFamily(color: Colors.lightGreen);
  static const amaranthaceae = SeedFamily(color: Colors.green);
  static const brassicaceae = SeedFamily(color: Colors.green);
  static const solanaceae = SeedFamily(color: Colors.red);
  static const poaceae = SeedFamily(color: Colors.yellow);
  static const cucurbitaceae = SeedFamily(color: Colors.orange);
  static const amaryllidaceae = SeedFamily(color: Colors.white);
}
