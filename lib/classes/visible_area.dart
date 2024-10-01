import 'package:game/classes/position.dart';

class VisibleArea {
  final Position center;
  final int width; // in tiles odd
  final int height; // in tiles odd

  const VisibleArea({
    required this.center,
    required this.width,
    required this.height,
  });

  int get tilesCount => width * height;

  Position positionAtIndex(int index) {
    int relativeX = (index % width);
    int relativeY = (index ~/ height);

    int relativeCenterX = (width ~/ 2);
    int relativeCenterY = (height ~/ 2);

    int absoluteX = center.x + (relativeX - relativeCenterX);
    int absoluteY = center.y + (relativeY - relativeCenterY);

    return Position(absoluteX, absoluteY);
  }
}
