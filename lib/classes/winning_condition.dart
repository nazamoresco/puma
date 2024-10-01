import 'package:game/flame_components/puma_game.dart';

class WiningCondition {
  final String Function(PumaGame game) label;
  final String Function(PumaGame game) victoryComment;
  final bool Function(PumaGame game) isGameWon;

  const WiningCondition({
    required this.label,
    required this.isGameWon,
    required this.victoryComment,
  });
}
