import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/score_badge.dart';
import '../models/quiz_state.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final bool isWin;
  final String playerName;

  const ResultScreen({
    Key? key,
    required this.score,
    required this.totalQuestions,
    this.isWin = false,
    this.playerName = '',
    String? imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quiz = Provider.of<QuizState>(context, listen: false);
    final imagePath = isWin
        ? 'assets/images/gold.png'
        : 'assets/images/lose.png';

    return Scaffold(
      backgroundColor: const Color(0xFF0B1023),
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  child: Image.asset('assets/images/gradient1.png', fit: BoxFit.cover),
                ),
                Expanded(
                  child: Image.asset('assets/images/gradient2.png', fit: BoxFit.cover),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(imagePath, height: 150),
                    const SizedBox(height: 20),
                    Text(
                      isWin ? 'Congrats!' : 'You lose!',
                      style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Score: $score / ${totalQuestions * 20}',
                      style: const TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                    const SizedBox(height: 30),
                    ScoreBadge(score: score),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        quiz.resetQuiz();
                        Navigator.pushReplacementNamed(
                          context,
                          '/home',
                          arguments: {'playerName': playerName},
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Back to Home'),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        quiz.startQuiz();
                        Navigator.pushReplacementNamed(
                          context,
                          '/quiz',
                          arguments: {'playerName': playerName}, // mark by me
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
