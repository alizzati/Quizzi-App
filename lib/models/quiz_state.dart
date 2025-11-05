import 'dart:async';
import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../utils/question_data.dart';

class QuizState extends ChangeNotifier {
  String _playerName = '';
  String get playerName => _playerName;

  final List<Question> questions = List.of(questionsData);
  int currentIndex = 0;
  late List<int?> userAnswers;
  int lives = 3;

  int timePerQuestion = 15;
  int timeLeft = 15;
  Timer? _timer;

  QuizState() {
    _init();
  }

  void setPlayerName(String name) {
    _playerName = name;
    notifyListeners();
  }

  void _init() {
    userAnswers = List<int?>.filled(questions.length, null);
    currentIndex = 0;
    lives = 3;
    timeLeft = timePerQuestion;
    _cancelTimer();
  }

  void startQuiz() {
    _init();
    startTimer();
    notifyListeners();
  }

  int get score {
    int s = 0;
    for (int i = 0; i < questions.length; i++) {
      if (userAnswers[i] != null && userAnswers[i] == questions[i].correctIndex) {
        s += 20;
      }
    }
    return s;
  }

  void selectAnswer(int index) {
    final prev = userAnswers[currentIndex];
    final correct = questions[currentIndex].correctIndex;

    if (prev == null) {
      userAnswers[currentIndex] = index;
      if (index != correct) lives = (lives - 1).clamp(0, 99);
    } else if (prev != index) {
      if (prev == correct && index != correct) lives = (lives - 1).clamp(0, 99);
      userAnswers[currentIndex] = index;
    }

    _cancelTimer();
    notifyListeners();
  }

  void nextQuestion() {
    if (currentIndex < questions.length - 1) {
      currentIndex++;
      resetTimer();
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (currentIndex > 0) {
      currentIndex--;
      resetTimer();
      notifyListeners();
    }
  }

  void startTimer() {
    _cancelTimer();
    timeLeft = timePerQuestion;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (timeLeft > 0) {
        timeLeft--;
        notifyListeners();
      } else {
        _onTimeUp();
      }
    });
  }

  void resetTimer() {
    _cancelTimer();
    timeLeft = timePerQuestion;
    startTimer();
  }

  void _onTimeUp() {
    _cancelTimer();
    lives = (lives - 1).clamp(0, 99);
    if (lives > 0 && currentIndex < questions.length - 1) {
      currentIndex++;
      timeLeft = timePerQuestion;
      startTimer();
    }
    notifyListeners();
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void stopTimer() {
    _cancelTimer();
    notifyListeners();
  }

  void disposeState() {
    _cancelTimer();
  }

  void resetQuiz() {
    // ⚠️ jangan hapus nama player
    _cancelTimer();
    _init();
    notifyListeners();
  }
}
