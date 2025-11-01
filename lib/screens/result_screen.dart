import 'package:flutter/material.dart';
import '../models/quiz_state.dart';
import 'home_screen.dart';


class ResultScreen extends StatelessWidget {
  final String playerName;
  const ResultScreen({Key? key, required this.playerName}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final QuizState state = QuizState.instance;
    final int correct = state.score;
    final int total = state.questions.length;
    final bool win = correct >= (total / 2);


    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(win ? 'Congrats!' : 'You lose!', style: Theme.of(context).textTheme.displaySmall),
                const SizedBox(height: 12),
                Text('Your Score', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 18),
                if (win)
                  Image.asset('assets/images/trophy.png', height: 120)
                else
                  Image.asset('assets/images/skull.png', height: 120),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    state.reset();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                          (route) => false,
                    );
                  },
                  child: const Text('Play again'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}