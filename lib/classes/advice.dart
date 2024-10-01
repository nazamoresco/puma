import 'package:game/classes/advice_activatables.dart';
import 'package:game/flame_components/puma_game.dart';

class Advice {
  final String text;
  final bool Function(PumaGame game) isGoodTiming;
  final AdviceActivatables? activable;

  /// 'wasFollowed' is a function that defines the logic to consider
  /// if a advice was followed by the player.
  ///
  /// A null values signifies that the users shouldn't take any
  /// action.
  final bool Function(PumaGame game)? wasFollowed;

  /// Does something before the advice is displayed.
  final bool Function(PumaGame game)? beforeDisplaying;

  /// Does something after if is dismissed 
  final bool Function(PumaGame game)? whenComplete;

  bool isHidden;

  Advice({
    this.activable,
    this.beforeDisplaying,
    this.isGoodTiming = _defaultFunction,
    this.wasFollowed,
    this.whenComplete,
    this.isHidden = false,
    required this.text,
  });

  static bool _defaultFunction(PumaGame game) {
    return true;
  }

  bool get isNotHidden => !isHidden;

  /// This function helps detects if the player acknowledged the
  /// advice. For actionable advices, this is with wasFollowed, it has
  /// to be followed, by non-actionable advices is enough with being hidden.
  bool wasAcknowledged(PumaGame game) {
    if (wasFollowed != null) {
      return wasFollowed!(game);
    } else {
      return isHidden;
    }
  }
}
