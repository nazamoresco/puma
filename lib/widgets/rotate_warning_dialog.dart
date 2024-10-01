import 'package:flutter/material.dart';

class RotateWarningDialog extends StatefulWidget {
  final void Function() onContinue;

  const RotateWarningDialog({
    super.key,
    required this.onContinue,
  });

  @override
  State<RotateWarningDialog> createState() => _RotateWarningDialogState();
}

class _RotateWarningDialogState extends State<RotateWarningDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat(reverse: true);

  late final _animation = Tween<double>(
    begin: .15,
    end: -0.15,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      title: const Text(
        'Rotá el celu para una mejor experiencia',
        style: TextStyle(
          fontSize: 36,
          color: Colors.brown,
        ),
        textAlign: TextAlign.center,
      ),
      content: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: RotationTransition(
          turns: _animation,
          child: const Icon(Icons.screen_rotation, size: 128),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Entiendo',
            style: TextStyle(
              fontSize: 36,
              color: Colors.brown,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            widget.onContinue();
          },
        ),
      ],
    );
  }
}
