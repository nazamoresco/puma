import 'package:game/classes/question_type.dart';

class Question {
  final String question;
  final QuestionType type;

  final List<String> options;
  final bool isOptional;

  const Question(
    this.question, {
    required this.type,
    this.options = const [],
    this.isOptional = false,
  });
}
