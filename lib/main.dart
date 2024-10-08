import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game/screens/home_screen.dart';
import 'package:game/screens/game_screen.dart';
import 'package:game/screens/thanks_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Crayonara",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
      initialRoute: "/home",
      routes: {
        "/home": (context) => const HomeScreen(),
        "/game": (context) => const GameScreen(),
        "/thanks": (context) => const ThanksScreen(),
      }
    );
  }
}
