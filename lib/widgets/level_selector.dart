import 'package:flutter/material.dart';
import 'package:game/widgets/rotate_warning_dialog.dart';

class LevelSelector extends StatelessWidget {
  final String title;
  final void Function() moveToLevel;

  const LevelSelector({
    super.key,
    required this.title,
    required this.isMobile,
    required this.moveToLevel,
  });

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.brown,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          minimumSize: const Size(170, 75),
        ),
        onPressed: () {
          if (isMobile) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => RotateWarningDialog(
                onContinue: moveToLevel,
              ),
            );
          } else {
            moveToLevel();
          }
        },
        child: Text(
          title,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontFamily: "Crayonara",
            color: Colors.white,
            fontSize: 48,
          ),
        ),
      ),
    );
  }
}
