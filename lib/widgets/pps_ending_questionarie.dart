import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:game/classes/question.dart';
import 'package:game/classes/question_type.dart';
import 'package:game/widgets/step_switch.dart';

class PpsEndingQuestionarie extends StatefulWidget {
  final void Function(int index, String answer) setResponse;
  final String? Function(int index) getResponse;
  final void Function() onClose;

  const PpsEndingQuestionarie({
    super.key,
    required this.onClose,
    required this.setResponse,
    required this.getResponse,
  });

  @override
  State<PpsEndingQuestionarie> createState() => _PpsEndingQuestionarieState();
}

class _PpsEndingQuestionarieState extends State<PpsEndingQuestionarie> {
  int _index = 0;

  static const List<Question> questions = [
    Question("Cual es tu edad?", type: QuestionType.number),
    Question("Cual es tu genero?", type: QuestionType.multipleChoice, options: [
      "Masculino",
      "Femenino",
      "Otro",
      "Prefiero no decir",
    ]),
    Question(
      "¿Qué tan seguido jugas videojuegos?",
      type: QuestionType.multipleChoice,
      options: [
        "Nunca",
        "1 vez por semana",
        "3 veces por semana",
        "Todos los días",
      ],
    ),
    Question(
      "¿El juego te fue fácil de entender?",
      type: QuestionType.multipleChoice,
      options: [
        "Muy fácil",
        "Fácil",
        "Ni fácil ni difícil",
        "Difícil",
        "Muy difícil",
      ],
    ),
    Question(
      "¿Pudiste encontrar fácilmente los elementos del juego?",
      type: QuestionType.multipleChoice,
      options: [
        "Rápidamente encontré todos los elementos",
        "Algunos elementos me costó encontrarlos pero en general pude jugar sin dificultad",
        "Muchos elementos no los encontré y se me dificultó avanzar en el juego",
      ],
    ),
    Question(
      "¿Hay algo que te hubiera gustado poder cambiar en el menú y no pudiste? (Colores, velocidad del juego, sonido, etc…)",
      type: QuestionType.text,
      isOptional: true,
    ),
    Question(
      "¿Me divertí jugando PUMA?",
      type: QuestionType.multipleChoice,
      options: [
        "Nada",
        "Un poco",
        "Mucho",
      ],
    ),
    Question(
      "¿Qué pensás de las imágenes utilizadas en el juego?",
      type: QuestionType.multipleChoice,
      options: [
        "Muy buenas",
        "Buenas",
        "Ni buenas ni malas",
        "Malas",
        "Muy malas",
      ],
    ),
    Question(
      "¿Qué te parecieron los sonidos y la música del juego?",
      type: QuestionType.multipleChoice,
      options: [
        "Muy buenos",
        "Buenos",
        "Ni buenos ni malos",
        "Malos",
        "Muy malos",
      ],
    ),
    Question(
      "¿Cómo calificarías la dificultad de los niveles?",
      type: QuestionType.multipleChoice,
      options: [
        "Muy fáciles",
        "Fáciles",
        "Moderados",
        "Difíciles",
        "Muy difíciles",
      ],
    ),
    Question(
      "¿Qué tan claros te parecieron los objetivos y desafíos de los niveles?",
      type: QuestionType.multipleChoice,
      options: [
        "Muy claros",
        "Claros",
        "Ni claros ni confusos",
        "Confusos",
        "Muy confusos",
      ],
    ),
    Question(
      "¿Volverías a jugar?",
      type: QuestionType.multipleChoice,
      options: [
        "Si",
        "No",
        "No sé",
      ],
    ),
    Question(
      "¿Se lo recomendarías a un amigo?",
      type: QuestionType.multipleChoice,
      options: [
        "Si",
        "No",
        "No sé",
      ],
    ),
    Question(
      "¿Qué fue lo que más te gustó del juego?",
      type: QuestionType.text,
      isOptional: true,
    ),
    Question(
      "¿Qué fue lo que menos te gustó del juego?",
      type: QuestionType.text,
      isOptional: true,
    ),
    Question(
      "¿Tenés alguna sugerencia para mejorar el juego?",
      type: QuestionType.text,
      isOptional: true,
    ),
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
