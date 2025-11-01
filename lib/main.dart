import 'package:flutter/material.dart';
import 'screens/home_screen.dart';


void main() {
  runApp(const QuizardApp());
}


class QuizardApp extends StatelessWidget {
  const QuizardApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Poppins',
      ),
      home: const HomeScreen(),
    );
  }
}