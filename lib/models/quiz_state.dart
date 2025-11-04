import 'dart:async';
import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../utils/question_data.dart';

class QuizState extends ChangeNotifier {
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

  QuizState() {
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

  // Pilih jawaban — simpan jawaban, update lives bila salah, jangan tampilkan benar/salah
  void selectAnswer(int index) {
    final prev = userAnswers[currentIndex];
    final correct = questions[currentIndex].correctIndex;

    // Jika belum pernah dipilih sebelumnya
    if (prev == null) {
      userAnswers[currentIndex] = index;
      if (index != correct) {
        lives = (lives - 1).clamp(0, 99);
      }
    } else if (prev != index) {
      // jika user mengganti jawaban, tangani perubahan lives dengan menyesuaikan
      if (prev == correct && index != correct) {
        // dari benar -> salah : reduce life
        lives = (lives - 1).clamp(0, 99);
      } else if (prev != correct && index == correct) {
        // dari salah -> benar : restore nothing (tidak menambah life)
        // (kebijakan: tidak menambah life)
      }
      userAnswers[currentIndex] = index;
    }
    // setelah memilih jawaban, stop timer (soal dianggap selesai)
    _cancelTimer();
    notifyListeners();

    // Jika lives habis, lanjut ke hasil akan di-handle oleh UI (cek state.lives)
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
        // waktu habis untuk soal ini
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
    // kurangi life 1 saat timer habis
    lives = (lives - 1).clamp(0, 99);

    // jika lives masih ada, pindah ke soal berikutnya (jika ada)
    if (lives > 0 && currentIndex < questions.length - 1) {
      currentIndex++;
      timeLeft = timePerQuestion;
      startTimer();
    } else {
      // lives habis atau tidak ada soal, biarkan UI menangani navigasi ke result
      notifyListeners();
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
