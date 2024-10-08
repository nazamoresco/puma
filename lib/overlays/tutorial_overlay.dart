import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:game/flame_components/puma_game.dart';

class TutorialOverlay extends StatelessWidget {
  final PumaGame game;

  const TutorialOverlay(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapOutside: (_) {
        game.overlays.remove("tutorial");
      },
      child: Stack(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * .8,
              height: MediaQuery.of(context).size.height * .9,
              constraints: const BoxConstraints(
                minWidth: 850,
                minHeight: 350,
                maxWidth: 900,
              ),
              color: const Color(0xFFFF9A76),
              padding: const EdgeInsets.all(32.0),
              child: StepperExample(onClose: () {
                game.overlays.remove("tutorial");
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class StepperExample extends StatefulWidget {
  final void Function() onClose;
  const StepperExample({super.key, required this.onClose});

  @override
  State<StepperExample> createState() => _StepperExampleState();
}

class _StepperExampleState extends State<StepperExample> {
  int _index = 0;

  static const int stepsCount = 3;

  void onStepCancel() {
    if (_index > 0) {
      setState(() {
        _index -= 1;
      });
    }
  }

  void onStepContinue() {
    if (_index + 1 < stepsCount) {
      setState(() {
        _index += 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: widget.onClose,
              icon: const Icon(
                Icons.close,
                color: Colors.brown,
                size: 32,
              ),
            ),
          ),
          StepSwitch(_index),
          const SizedBox(height: 8),
          Row(
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 246, 104, 52),
                  disabledBackgroundColor:
                      const Color.fromARGB(255, 239, 196, 180),
                  padding: const EdgeInsets.all(16),
                ),
                onPressed: _index + 1 < stepsCount ? onStepContinue : null,
                child: const Text(
                  "Continuar",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontFamily: "Crayonara",
                    fontWeight: FontWeight.normal,
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 246, 104, 52),
                  disabledBackgroundColor:
                      const Color.fromARGB(255, 239, 196, 180),
                  padding: const EdgeInsets.all(16),
                ),
                onPressed: _index > 0 ? onStepCancel : null,
                child: const Text(
                  "Atras",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontFamily: "Crayonara",
                    fontWeight: FontWeight.normal,
                    fontSize: 24,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class StepSwitch extends StatelessWidget {
  final int index;

  const StepSwitch(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return Center(
          child: Column(
            children: [
              const Text(
                textAlign: TextAlign.center,
                'En nivel este aprenderas como jugar PUMA. \n Haz 50 monedas y desbloquea todas los platos para pasar al siguiente nivel.',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontFamily: "Crayonara",
                  fontWeight: FontWeight.normal,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .5,
                child: RawImage(
                  image: Flame.images.fromCache("tutorial_1.png"),
                ),
              ),
            ],
          ),
        );
      case 1:
        return Center(
          child: Column(
            children: [
              const Text(
                'Gana monedas haciendo platos para el Sapo en la cocina!',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontFamily: "Crayonara",
                  fontWeight: FontWeight.normal,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .5,
                child: RawImage(
                  image: Flame.images.fromCache("tutorial_2.png"),
                ),
              ),
            ],
          ),
        );
      case 2:
        return Center(
          child: Column(
            children: [
              const Text(
                'Compra y planta semillas para obtener ingredientes para tus platos!',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontFamily: "Crayonara",
                  fontWeight: FontWeight.normal,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .5,
                child: RawImage(
                  image: Flame.images.fromCache("tutorial_3.png"),
                ),
              ),
            ],
          ),
        );
    }
    return Container();
  }
}
