import 'package:flutter/material.dart';
import 'package:game/classes/question.dart';
import 'package:game/classes/question_type.dart';
import 'package:game/widgets/question_option.dart';

class StepSwitch extends StatelessWidget {
  final void Function(int index, String answer) setResponse;
  final String? Function(int index) getResponse;
  final int index;
  final int questionCount;
  final Question question;
  final void Function() next;
  final void Function() previous;

  const StepSwitch(
    this.question, {
    super.key,
    required this.index,
    required this.next,
    required this.previous,
    required this.setResponse,
    required this.getResponse,
    required this.questionCount,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/COCINA_fondo.webp"),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                color: const Color(0xFFb06346),
                child: Text(
                  textAlign: TextAlign.center,
                  question.question,
                  style: const TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontFamily: "Crayonara",
                    fontWeight: FontWeight.normal,
                    fontSize: 32,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ...getOptions(),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...(index > 0
                      ? [
                          OptionButton(
                              text: "< Pregunta Previa", onPressed: previous)
                        ]
                      : []),
                  ...(index > 0 &&
                          (question.isOptional || getResponse(index) != null)
                      ? const [SizedBox(width: 16)]
                      : []),
                  ...((question.isOptional || getResponse(index) != null)
                      ? [
                          OptionButton(
                              text: "Siguiente Pregunta >", onPressed: next)
                        ]
                      : []),
                ],
              ),
              const SizedBox(height: 8),
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    height: 10,
                    width: 300,
                    color: const Color(0xFFb06346).withAlpha(100),
                  ),
                  Container(
                    height: 10,
                    width: 300 * (index + 1) / questionCount,
                    color: const Color(0xFFb06346),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 300 * (index + 1) / questionCount - 5),
                    child: const Image(
                      height: 32,
                      image: AssetImage("assets/images/personaje_512.webp"),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getOptions() {
    switch (question.type) {
      case QuestionType.multipleChoice:
        return question.options.map<Widget>((option) {
          return QuestionOption(
            text: option,
            isSelected: getResponse(index) == option,
            onPressed: () {
              setResponse(index, option);
              next();
            },
          );
        }).toList();
      case QuestionType.number:
      case QuestionType.text:
        return [
          QuestionAnswer(
              question: question,
              setResponse: setResponse,
              index: index,
              next: next,
              getResponse: getResponse)
        ];
    }
  }
}

class QuestionAnswer extends StatefulWidget {
  const QuestionAnswer({
    super.key,
    required this.question,
    required this.setResponse,
    required this.getResponse,
    required this.index,
    required this.next,
  });

  final Question question;
  final void Function(int index, String answer) setResponse;
  final String? Function(int index) getResponse;
  final int index;
  final void Function() next;

  @override
  State<QuestionAnswer> createState() => _QuestionAnswerState();
}

class _QuestionAnswerState extends State<QuestionAnswer> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        TextEditingController(text: widget.getResponse(widget.index) ?? "");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant QuestionAnswer oldWidget) {
    if (widget.index != oldWidget.index) {
      _controller.text = widget.getResponse(widget.index) ?? "";
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        constraints: const BoxConstraints(minWidth: 300),
        child: TextField(
          controller: _controller,
          decoration: const InputDecoration(),
          style: const TextStyle(
            color: Colors.black,
            fontFamily: "Crayonara",
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
          keyboardType: widget.question.type == QuestionType.number
              ? TextInputType.number
              : null,
          onChanged: (value) {
            widget.setResponse(widget.index, value);
          },
          onSubmitted: (_) => widget.next(),
        ),
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  const OptionButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: const Color(0xFFb06346),
        child: Text(
          textAlign: TextAlign.center,
          text,
          style: const TextStyle(
            decoration: TextDecoration.none,
            color: Colors.black,
            fontFamily: "Crayonara",
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
