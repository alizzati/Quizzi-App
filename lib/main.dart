import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/result_screen.dart';
import 'screens/profile_screen.dart';
import 'theme/light_theme.dart';
import 'theme/dark_theme.dart';

void main() {
  runApp(const QuizardApp());
}

class QuizardApp extends StatelessWidget {
  const QuizardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quizard',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: '/welcome',
      routes: {
        '/welcome': (_) => const WelcomeScreen(),
        '/signup': (_) => const SignUpScreen(),
        '/home': (_) => const HomeScreen(playerName: ''),
        '/quiz': (_) => const QuizScreen(),
        '/result': (_) => const ResultScreen(
          score: 0,
          totalQuestions: 0,
          isWin: true,
          imagePath: '',
        ),
        '/profile': (_) => const ProfileScreen(),
      },
    );
  }
}
