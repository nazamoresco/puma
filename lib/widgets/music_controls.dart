import 'package:flutter/material.dart';
import 'package:game/flame_components/puma_game.dart';

class MusicControls extends StatefulWidget {
  const MusicControls({
    super.key,
    required this.game,
  });

  final PumaGame game;

  @override
  State<MusicControls> createState() => _MusicControlsState();
}

class _MusicControlsState extends State<MusicControls> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Volumen Musica",
          style: TextStyle(
            decoration: TextDecoration.none,
            color: Colors.black,
            fontFamily: "Crayonara",
            fontWeight: FontWeight.normal,
            fontSize: 24,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * .5,
          constraints: const BoxConstraints(
            maxWidth: 350,
          ),
          child: Material(
            color: Colors.transparent,
            child: Slider(
              value: widget.game.musicVolume,
              min: 0.0,
              max: 0.5,
              onChanged: (value) {
                widget.game.musicVolume = value;
                setState(() {});
              },
            ),
          ),
        ),
      ],
    );
  }
}
