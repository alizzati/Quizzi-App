import '../models/question_model.dart';


final List<Question> sampleQuestions = [
  Question(
    questionText: 'How many wizards were killed in making of Uizard?',
    options: ['None', '10', '50', 'All of them'],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Which tool is primarily used for UI design?',
    options: ['Excel', 'Figma', 'Word', 'Terminal'],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What does SDK stand for?',
    options: [
      'Software Development Kit',
      'Simple Design Kit',
      'System Dev Key',
      'Software Data Kit'
    ],
    correctAnswerIndex: 0,
  ),
];