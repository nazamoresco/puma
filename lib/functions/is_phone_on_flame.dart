import 'package:flame/components.dart';

bool isPhoneOnFlame(Vector2 viewportSize) {
  return viewportSize.y < 600;
}