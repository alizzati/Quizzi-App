import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/quiz_state.dart';
import 'screens/welcome_screen.dart';
import 'theme/light_theme.dart';
import 'theme/dark_theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => QuizState(), // menyediakan state global
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
      home: const WelcomeScreen(),
      routes: {
        '/welcome': (_) => const WelcomeScreen(),
        // tambahkan route lainnya seperti signup, home, quiz, result
      },
    );
  }
}
