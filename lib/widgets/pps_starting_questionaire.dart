import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:game/classes/question.dart';
import 'package:game/classes/question_type.dart';
import 'package:game/widgets/step_switch.dart';

class PpsStartingQuestionaire extends StatefulWidget {
  final void Function(int index, String answer) setResponse;
  final String? Function(int index) getResponse;
  final void Function() onClose;

  const PpsStartingQuestionaire({
    super.key,
    required this.onClose,
    required this.setResponse,
    required this.getResponse,
  });

  @override
  State<PpsStartingQuestionaire> createState() =>
      _PpsStartingQuestionaireState();
}

class _PpsStartingQuestionaireState extends State<PpsStartingQuestionaire> {
  int _index = 0;

  static const List<Question> questions = [
    Question(
      "¿Creés que lo que comemos afecta lo que se cultiva en las huertas?",
      type: QuestionType.multipleChoice,
      options: [
        "Sí, porque los agricultores cultivan lo que las personas quieren comer.",
        "No, porque los agricultores cultivan siempre lo mismo, sin importar lo que comemos.",
        "No estoy seguro.",
      ],
    ),
    Question(
      "¿Cultivar repetitivamente el mismo cultivo es bueno para el suelo?",
      type: QuestionType.multipleChoice,
      options: [
        "Sí, porque el suelo se acostumbra al cultivo.",
        "No, porque el suelo se agota más rápido por cultivar siempre lo mismo.",
        "No estoy seguro.",
      ],
    ),
    Question(
      "¿Cultivar siempre el mismo cultivo ayuda a evitar plagas?",
      type: QuestionType.multipleChoice,
      options: [
        "Sí, porque las plagas se cansan de comer siempre lo mismo.",
        "No, las plagas aumentan porque tienen disponible el alimento que necesitan.",
        "No estoy seguro.",
      ],
    ),
    Question(
      "¿Comer siempre poca variedad de verduras es bueno para el ambiente?",
      type: QuestionType.multipleChoice,
      options: [
        "Sí, porque se cultiva más fácil y con menos insumos.",
        "No, porque se reduce la biodiversidad y las funciones que esta cumple en el ambiente.",
        "No estoy seguro.",
      ],
    ),
    Question(
      "¿Comer verduras de estación (son las que se cultivan en la misma estación en que son consumidas) es bueno para el ambiente?",
      type: QuestionType.multipleChoice,
      options: [
        "Sí, se requieren menos insumos y energía que si son producidas fuera de estación.",
        "No, es lo mismo producirlas en cualquier momento del año.",
        "No estoy seguro.",
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  void onStepCancel() {
    if (_index > 0) {
      setState(() {
        _index -= 1;
      });
    }
  }

  void onStepContinue() {
    if (_index + 1 < questions.length) {
      setState(() {
        _index += 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StepSwitch(
          questions[_index],
          index: _index,
          questionCount: questions.length,
          setResponse: widget.setResponse,
          getResponse: widget.getResponse,
          next: () {
            _index + 1 < questions.length ? onStepContinue() : widget.onClose();
          },
          previous: () => setState(() {
            _index -= 1;
          }),
        ),
      ),
    );
  }
}
