import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/score_badge.dart';
import '../providers/quiz_state.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  const ResultScreen({Key? key, required this.score, required this.totalQuestions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quiz = Provider.of<QuizState>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFF0B1023),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScoreBadge(score: score),
                const SizedBox(height: 20),
                Text('Score: $score / ${totalQuestions * 20}', style: const TextStyle(color: Colors.white, fontSize: 18)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // kembali ke home
                    quiz.resetQuiz();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen(playerName: '')));
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  child: const Text('Back to Home'),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    // try again
                    quiz.startQuiz();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen(playerName: '')));
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
