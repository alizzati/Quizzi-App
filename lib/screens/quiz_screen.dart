import 'dart:async';
import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../utils/question_data.dart';
import '../widgets/custom_button.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  int score = 0;
  int lives = 3;
  int timeLeft = 60;
  Timer? countdownTimer;
  int? selectedIndex;
  List<int?> userAnswers = List.filled(5, null); // untuk 5 soal

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() => timeLeft--);
      } else {
        timer.cancel();
        goToResult(isWin: false, image: 'assets/images/lose.png');
      }
    });
  }

  void goToResult({required bool isWin, required String image}) {
    countdownTimer?.cancel();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          score: score,
          totalQuestions: questionsData.length,
          isWin: isWin,
          imagePath: image,
        ),
      ),
    );
  }

  void selectAnswer(int index) {
    final currentQuestion = questionsData[currentIndex];
    final prevAnswer = userAnswers[currentIndex];

    setState(() {
      selectedIndex = index;
      userAnswers[currentIndex] = index;

      if (prevAnswer == null) {
        // jawaban baru
        if (index == currentQuestion.correctIndex) {
          score += 20;
        } else {
          lives--;
        }
      } else {
        // jika ubah jawaban dari benar ke salah
        if (prevAnswer == currentQuestion.correctIndex &&
            index != currentQuestion.correctIndex) {
          score -= 20;
          lives--;
        }
        // jika ubah dari salah ke benar
        else if (prevAnswer != currentQuestion.correctIndex &&
            index == currentQuestion.correctIndex) {
          score += 20;
        }
      }

      // Jika nyawa habis
      if (lives <= 0) {
        goToResult(isWin: false, image: 'assets/images/lose.png');
      }
    });
  }

  void nextQuestion() {
    if (currentIndex < questionsData.length - 1) {
      setState(() {
        currentIndex++;
        selectedIndex = userAnswers[currentIndex];
      });
    } else {
      goToResult(isWin: true, image: 'assets/images/gold.png');
    }
  }

  void previousQuestion() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        selectedIndex = userAnswers[currentIndex];
      });
    }
  }

  Color getAnswerColor(int index) {
    final currentQuestion = questionsData[currentIndex];
    final selected = userAnswers[currentIndex];

    if (selected == null) return Colors.white;
    if (index == currentQuestion.correctIndex) return Colors.greenAccent;
    if (index == selected && index != currentQuestion.correctIndex) {
      return Colors.redAccent;
    }
    return Colors.white;
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questionsData[currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF0B1023),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top bar: timer & hearts
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.timer, color: Colors.white),
                      const SizedBox(width: 5),
                      Text("$timeLeft s",
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: List.generate(
                      3,
                          (i) => Icon(
                        i < lives
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: Colors.pinkAccent,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Text(
                "Question ${currentIndex + 1} of ${questionsData.length}",
                style:
                const TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                currentQuestion.text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              // Option buttons
              Column(
                children: List.generate(currentQuestion.options.length, (i) {
                  final option = currentQuestion.options[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: GestureDetector(
                      onTap: () => selectAnswer(i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 14),
                        decoration: BoxDecoration(
                          color: getAnswerColor(i),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.white30),
                        ),
                        child: Text(
                          option,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),

              const Spacer(),

              // Navigation buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    text: "Previous",
                    onPressed:
                    currentIndex > 0 ? previousQuestion : null,
                    color: Colors.grey[800]!,
                  ),
                  CustomButton(
                    text: currentIndex == questionsData.length - 1
                        ? "Finish"
                        : "Next",
                    onPressed: userAnswers[currentIndex] != null
                        ? nextQuestion
                        : null,
                    color: Colors.blueAccent,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
