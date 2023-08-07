import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loshical/question_screen.dart';
import 'package:loshical/result_screen.dart';

void main() {
  runApp(const ProviderScope(child: Loshical()));
}

class Loshical extends StatelessWidget {
  const Loshical({super.key});

  static final resultProvider = StateProvider((ref) => GameState('', false));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'homePage',
      routes: {
        'homePage': (context) => QuestionScreen(),
        'result': (context) => ResultScreen(),
      },
    );
  }
}

class GameState {
  String selectedPath = '';
  bool correct = false;

  GameState(String selectedPath, bool correct) {
    this.selectedPath = selectedPath;
    this.correct = correct;
  }
}
