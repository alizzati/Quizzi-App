import 'question_model.dart';


class QuizState {
  QuizState._privateConstructor();
  static final QuizState instance = QuizState._privateConstructor();


  late List<Question> questions;
  int currentIndex = 0;
  int score = 0;
  List<int?> userAnswers = [];


  void init(List<Question> qs) {
    questions = qs;
    currentIndex = 0;
    score = 0;
    userAnswers = List<int?>.filled(qs.length, null);
  }


  void answer(int index) {
    if (userAnswers[currentIndex] == null) {
      userAnswers[currentIndex] = index;
      if (questions[currentIndex].correctAnswerIndex == index) score += 1;
    } else {
// if changing answer, update score accordingly
      int? prev = userAnswers[currentIndex];
      if (prev != null && prev != index) {
        if (questions[currentIndex].correctAnswerIndex == prev) score -= 1;
        if (questions[currentIndex].correctAnswerIndex == index) score += 1;
        userAnswers[currentIndex] = index;
      }
    }
  }


  bool get isFinished => currentIndex >= questions.length - 1;


  void next() {
    if (currentIndex < questions.length - 1) currentIndex += 1;
  }


  void previous() {
    if (currentIndex > 0) currentIndex -= 1;
  }


  void reset() {
    for (int i = 0; i < userAnswers.length; i++) userAnswers[i] = null;
    currentIndex = 0;
    score = 0;
  }
}