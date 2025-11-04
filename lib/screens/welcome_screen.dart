import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome to Quizard!',
                    style: Theme.of(context).textTheme.displaySmall),
                const SizedBox(height: 20),
                Image.asset('.../assets/images/hartakarun.png', height: 200),
                const SizedBox(height: 40),
                CustomButton(
                  label: 'Get Started',
                  onPressed: () => Navigator.pushNamed(context, '/signup'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
