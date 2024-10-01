import 'package:flame/components.dart';

/// Multiplies the first Vector2 target the second Vector2 keeping the
/// aspect ratio of first Vector2. Target -1 means not use it.
Vector2 scaleKeepingAspectRatio({
  required Vector2 aspectRatio,
  required Vector2 target,
}) {
  if (target.toSize().longestSide == target.x) {
    return Vector2(target.x, aspectRatio.y * target.x / aspectRatio.x);
  } else {
    return Vector2(aspectRatio.x * target.y / aspectRatio.y, target.y);
  }
}
