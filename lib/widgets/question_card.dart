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

    return Center( // memastikan posisi di tengah layar
      child: Card(
        margin: EdgeInsets.all(padding),
        color: Colors.white.withOpacity(0.2), // 🔹 ini membuat background transparan
        elevation: 6, // bisa kamu ubah ke 0 jika mau benar-benar flat
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.white.withOpacity(0.3)), // opsional, efek outline lembut
        ),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            mainAxisSize: MainAxisSize.min, // supaya tidak mengambil seluruh tinggi layar
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                question.text,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white, // biar kontras dengan background transparan
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ...List.generate(question.options.length, (i) {
                final bool isSelected = selectedIndex == i;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: GestureDetector(
                    onTap: () => onSelect(i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.indigo.withOpacity(0.3)
                            : Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected ? Colors.indigoAccent : Colors.white24,
                        ),
                      ),
                      child: Text(
                        question.options[i],
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
