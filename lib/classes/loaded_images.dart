import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoadedImages with ChangeNotifier {
  final Map<String, ui.Image> imagePathHash = {};

  Future loadImage(String imagePath) async {
    final data = await rootBundle.load(imagePath);
    imagePathHash[imagePath] = await decodeImageFromList(data.buffer.asUint8List());
  }

  LoadedImages();
}
