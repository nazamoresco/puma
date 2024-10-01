import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game/flame_components/puma_game.dart';

class FrogCommentWidget extends StatefulWidget {
  final PumaGame game;

  const FrogCommentWidget(this.game, {super.key});

  @override
  State<FrogCommentWidget> createState() => _FrogCommentWidgetState();
}

class _FrogCommentWidgetState extends State<FrogCommentWidget> {
  late final Timer _timer;

  @override
  void initState() {
    // Fetch a new comment every 5 seconds
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
      // Fetch a new comment here
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Text(
        widget.game.frog.comment,
        textAlign: TextAlign.end,
        style: const TextStyle(
          decoration: TextDecoration.none,
          fontFamily: "Crayonara",
          color: Colors.brown,
          fontSize: 20,
        ),
      ),
    );
  }
}
