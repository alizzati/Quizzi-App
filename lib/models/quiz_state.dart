import '../utils/question_data.dart';
import '../models/question_model.dart';

class QuizState {
  static final QuizState instance = QuizState._internal();
  factory QuizState() => instance;
  QuizState._internal();

  late List<Question> questions;
  int currentIndex = 0;
  int? selectedIndex;
  int score = 0;
  bool isAnswered = false;

  final List<int?> userAnswers = List.filled(5, null);

  void init() {
    // ambil dari question_data.dart
    questions = List.of(questionsData);
  }

  void answer(int index) {
    if (!isAnswered) {
      selectedIndex = index;
      userAnswers[currentIndex] = index;
      isAnswered = true;

      if (questions[currentIndex].correctIndex == index) {
        score += 20;
      }
    }
  }

  void next() {
    if (currentIndex < questions.length - 1) {
      currentIndex++;
      isAnswered = false;
    }
  }

  void previous() {
    if (currentIndex > 0) {
      currentIndex--;
      isAnswered = false;
    }
  }

  void reset() {
    currentIndex = 0;
    score = 0;
    selectedIndex = null;
    isAnswered = false;
    for (int i = 0; i < userAnswers.length; i++) {
      userAnswers[i] = null;
    }
  }
}
