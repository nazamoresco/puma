import 'package:flutter/material.dart';

class QuestionOption extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSelected;

  const QuestionOption({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 200,
          ),
          color:
              isSelected ? Color(0xFFb06346) : Color(0xFFb06346).withAlpha(100),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              textAlign: TextAlign.center,
              text,
              style: const TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black,
                fontFamily: "Crayonara",
                fontWeight: FontWeight.normal,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
