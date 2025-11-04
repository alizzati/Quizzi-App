import 'dart:async';
import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../utils/question_data.dart';

class QuizState extends ChangeNotifier {
  // 🧩 Tambahan: nama pemain
  String playerName;

  // Data
  final List<Question> questions = List.of(questionsData);

  // Progress
  int currentIndex = 0;
  late List<int?> userAnswers; // menyimpan indeks jawaban user per soal
  int lives = 3;

  // Timer per soal
  int timePerQuestion = 15;
  int timeLeft = 15;
  Timer? _timer;

  // 🧩 Konstruktor menerima nama pemain
  QuizState({required this.playerName}) {
    _init();
  }

  void _init() {
    userAnswers = List<int?>.filled(questions.length, null);
    currentIndex = 0;
    lives = 3;
    timeLeft = timePerQuestion;
    _cancelTimer();
  }

  // Mulai quiz / reset
  void startQuiz() {
    _init();
    startTimer();
    notifyListeners();
  }

  // Score dihitung dari userAnswers
  int get score {
    int s = 0;
    for (int i = 0; i < questions.length; i++) {
      if (userAnswers[i] != null && userAnswers[i] == questions[i].correctIndex) {
        s += 20; // tiap soal 20 poin
      }
    }
    return s;
  }

  void setPlayerName(String name) {
    playerName = name;
    notifyListeners();
  }

  // Pilih jawaban — simpan jawaban, update lives bila salah, jangan tampilkan benar/salah
  void selectAnswer(int index) {
    final prev = userAnswers[currentIndex];
    final correct = questions[currentIndex].correctIndex;

    if (prev == null) {
      userAnswers[currentIndex] = index;
      if (index != correct) {
        lives = (lives - 1).clamp(0, 99);
      }
    } else if (prev != index) {
      if (prev == correct && index != correct) {
        lives = (lives - 1).clamp(0, 99);
      }
      userAnswers[currentIndex] = index;
    }

    _cancelTimer();
    notifyListeners();
  }

  // Navigasi
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

  // Timer management
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

  // Reset / ulang quiz
  void resetQuiz() {
    _cancelTimer();
    _init();
    notifyListeners();
  }
}
