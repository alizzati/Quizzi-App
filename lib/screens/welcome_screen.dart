import 'package:flutter/material.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Welcome to Quizard!', style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: 20),
              Image.asset('assets/images/hartakarun.png', height: 160),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/signup'),
                child: const Text('Get Started'),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
