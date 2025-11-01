import 'package:flutter/material.dart';
import '../models/quiz_state.dart';
import '../widgets/question_card.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String playerName;
  const QuizScreen({Key? key, required this.playerName}) : super(key: key);


  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with AutomaticKeepAliveClientMixin {
  final QuizState state = QuizState.instance;


  @override
  void initState() {
    super.initState();
// state should be initialized from Home before pushing this screen
  }


  void _select(int index) {
    setState(() {
      state.answer(index);
    });
  }

  void _next() {
    if (state.currentIndex < state.questions.length - 1) {
      setState(() {
        state.next();
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => ResultScreen(playerName: widget.playerName)),
      );
    }
  }


  void _previous() {
    setState(() {
      state.previous();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final q = state.questions[state.currentIndex];
    final selected = state.userAnswers[state.currentIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz - ${widget.playerName}'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: QuestionCard(
              question: q,
              questionNumber: state.currentIndex + 1,
              selectedIndex: selected,
              onSelect: _select,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (state.currentIndex > 0)
                  TextButton(onPressed: _previous, child: const Text('Previous'))
                else
                  const SizedBox(width: 88),
                ElevatedButton(onPressed: _next, child: Text(state.currentIndex < state.questions.length - 1 ? 'Next' : 'Finish')),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}