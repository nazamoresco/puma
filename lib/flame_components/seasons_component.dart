import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:game/classes/season.dart';
import 'package:game/flame_components/puma_game.dart';

class SeasonsComponent extends SpriteGroupComponent<Season>
  with HasGameRef<PumaGame>, HasVisibility {
  Season? _season;

  Season? get season => _season;

  set season(Season? value) {
    _season = value;
    current = value;
  }

  SeasonsComponent(this._season);

  @override
  onLoad() {
    isVisible = game.featureExposure.areSeasonsExposed;

    final winterSprite =
        Sprite(Flame.images.fromCache(Season.winter.imagePath));
    final fallSprite = Sprite(Flame.images.fromCache(Season.fall.imagePath));
    final springSprite =
        Sprite(Flame.images.fromCache(Season.spring.imagePath));
    final summerSprite =
        Sprite(Flame.images.fromCache(Season.summer.imagePath));

    sprites = {
      Season.winter: winterSprite,
      Season.fall: fallSprite,
      Season.spring: springSprite,
      Season.summer: summerSprite,
    };

    if(season != null) current = season;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    isVisible = game.featureExposure.areSeasonsExposed;
    super.update(dt);
  }
}
