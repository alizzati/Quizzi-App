import 'package:flutter/material.dart';
import 'quiz_screen.dart';
import '../models/quiz_state.dart';
import '../utils/question_data.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();


  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }


  void _startQuiz() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter your name')));
      return;
    }
    QuizState.instance.init(sampleQuestions);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => QuizScreen(playerName: name)),
    );
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Quizard', style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: 10),
              SizedBox(
                height: height * 0.28,
                child: Image.asset('assets/images/treasure.png', fit: BoxFit.contain),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Enter your name'),
              ),
              const SizedBox(height: 20),
              CustomButton(label: 'Start Quiz', onPressed: _startQuiz),
            ],
          ),
        ),
      ),
    );
  }
}