import '../models/question_model.dart';

final List<Question> questionsData = [
  Question(
    text: 'Apa kepanjangan dari CPU?',
    options: [
      'Central Processing Unit',
      'Central Power Unit',
      'Computer Personal Unit',
      'Control Processing Utility'
    ],
    correctIndex: 0,
  ),
  Question(
    text: 'Bahasa pemrograman yang digunakan Flutter adalah?',
    options: ['Java', 'Kotlin', 'Dart', 'Swift'],
    correctIndex: 2,
  ),
  Question(
    text: 'Widget mana yang digunakan untuk tata letak vertikal di Flutter?',
    options: ['Row', 'Column', 'Stack', 'Container'],
    correctIndex: 1,
  ),
  Question(
    text: 'Apa fungsi main.dart dalam aplikasi Flutter?',
    options: [
      'Menampilkan UI',
      'Sebagai titik awal aplikasi',
      'Menyimpan gambar',
      'Menjalankan emulator'
    ],
    correctIndex: 1,
  ),
  Question(
    text: 'Siapa yang mengembangkan Flutter?',
    options: ['Facebook', 'Microsoft', 'Google', 'Apple'],
    correctIndex: 2,
  ),
];
