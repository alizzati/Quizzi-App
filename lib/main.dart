import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/quiz_state.dart';
import 'theme/light_theme.dart';
import 'theme/dark_theme.dart';
import 'screens/welcome_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/result_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuizState()), // ✅ tidak perlu parameter playerName
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quizard',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,

      // ✅ Routing utama
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
        '/quiz': (context) => const QuizScreen(),
        '/result': (context) {
          final args = ModalRoute
              .of(context)
              ?.settings
              .arguments as Map<String, dynamic>?;
          final int score = args?['score'] ?? 0;
          final int totalQuestions = args?['totalQuestions'] ?? 0;
          final bool isWin = args?['isWin'] ?? false;
          final String? imagePath = args?['imagePath'] as String?;

          return ResultScreen(
            score: score,
            totalQuestions: totalQuestions,
            isWin: isWin,
            imagePath: imagePath,
          );
        }
      },
    );
  }
}
