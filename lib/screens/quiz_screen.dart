import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_state.dart';
import '../widgets/question_card.dart';
import '../widgets/custom_button.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    // startTimer dipanggil oleh provider.startQuiz() dari HomeScreen
  }

  @override
  void dispose() {
    Provider.of<QuizState>(context, listen: false).stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizState>(
      builder: (context, quiz, child) {
        // jika nyawa habis -> langsung ke result
        if (quiz.lives <= 0) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ResultScreen(score: quiz.score, totalQuestions: quiz.questions.length)));
          });
        }

        final question = quiz.questions[quiz.currentIndex];

        return Scaffold(
          backgroundColor: const Color(0xFF0B1023),
          body: SafeArea(
            child: Column(
              children: [
                // Top bar: timer & lives
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.timer, color: Colors.white),
                          const SizedBox(width: 6),
                          Text('${quiz.timeLeft}s', style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                      Row(
                        children: List.generate(3, (i) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Icon(i < quiz.lives ? Icons.favorite : Icons.favorite_border, color: Colors.pinkAccent),
                          );
                        }),
                      ),
                    ],
                  ),
                ),

                // Question card
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Text('Question ${quiz.currentIndex + 1} of ${quiz.questions.length}', style: const TextStyle(color: Colors.white70)),
                        const SizedBox(height: 8),
                        QuestionCard(
                          question: question,
                          questionNumber: quiz.currentIndex + 1,
                          selectedIndex: quiz.userAnswers[quiz.currentIndex],
                          onSelect: (index) {
                            quiz.selectAnswer(index);
                            // jika lives habis setelah memilih -> pindah hasil
                            if (quiz.lives <= 0) {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ResultScreen(score: quiz.score, totalQuestions: quiz.questions.length)));
                              return;
                            }
                            // jika masih ada, lanjut otomatis? di sini kita biarkan user menekan Next
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // Navigation buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          label: 'Previous',
                          onPressed: quiz.currentIndex > 0
                              ? () {
                            quiz.previousQuestion();
                          }
                              : null,
                          height: 48,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomButton(
                          label: quiz.currentIndex == quiz.questions.length - 1 ? 'Finish' : 'Next',
                          onPressed: quiz.userAnswers[quiz.currentIndex] != null
                              ? () {
                            // if last question -> show result
                            if (quiz.currentIndex == quiz.questions.length - 1) {
                              // stop timer
                              quiz.stopTimer();
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ResultScreen(score: quiz.score, totalQuestions: quiz.questions.length)));
                            } else {
                              quiz.nextQuestion();
                            }
                          }
                              : null,
                          height: 48,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
