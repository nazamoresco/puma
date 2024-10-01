import 'package:flutter/material.dart';

class TileType {
  final Color color;

  TileType({ required this.color});

  static final dirt = TileType(color: Colors.brown[300]!);
  static final water = TileType(color: Colors.blue[300]!);
}