import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../utils/question_data.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final bool isWin; // true = win, false = lose
  final String? imagePath;

  const ResultScreen({
    Key? key,
    required this.score,
    required this.totalQuestions,
    required this.isWin,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = isWin ? "Congratulations!" : "You Lose!";
    String message = isWin
        ? "You’ve completed the quiz with a score of $score!"
        : "Better luck next time!";

    return Scaffold(
      backgroundColor: const Color(0xFF0B1023),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imagePath != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Image.asset(
                    imagePath!,
                    height: 180,
                  ),
                ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Score: $score / ${totalQuestions * 20}",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen(playerName: '',)),
                  );
                },
                child: const Text(
                  "Back to Home",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              if (!isWin)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/quiz');
                  },
                  child: const Text(
                    "Try Again",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
