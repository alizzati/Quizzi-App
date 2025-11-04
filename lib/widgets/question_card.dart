import 'package:flutter/material.dart';
import '../models/question_model.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final int questionNumber;
  final int? selectedIndex;
  final void Function(int) onSelect;

  const QuestionCard({
    Key? key,
    required this.question,
    required this.questionNumber,
    required this.onSelect,
    this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double padding = 16;
    return Card(
      margin: EdgeInsets.all(padding),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Text('Question $questionNumber', style: Theme.of(context).textTheme.titleMedium),
            // const SizedBox(height: 8),
            Text(question.text, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 50),
            ...List.generate(question.options.length, (i) {
              final bool isSelected = selectedIndex == i;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: GestureDetector(
                  onTap: () => onSelect(i),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.indigo.shade50 : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: isSelected ? Colors.indigo : Colors.grey.shade300),
                    ),
                    child: Text(question.options[i], style: const TextStyle(fontSize: 16)),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
