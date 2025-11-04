import 'package:flutter/material.dart';

class ScoreBadge extends StatelessWidget {
  final int score;
  const ScoreBadge({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String emoji;
    if (score >= 80) {
      emoji = "🏅";
    } else if (score >= 60) {
      emoji = "🎖️";
    } else {
      emoji = "💪";
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24, width: 2),
      ),
      child: Column(
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 56),
          ),
          const SizedBox(height: 10),
          Text(
            '$score pts',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
