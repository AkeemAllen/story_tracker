import 'package:flutter/material.dart';
import '../components/question.dart';
import '../components/answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> question;
  final int questionIndex;
  final Function answerQuestion;

  Quiz({
    @required this.answerQuestion,
    @required this.question,
    @required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Question(question[questionIndex]['question']),
          // Headline(),
          ...(question[questionIndex]['answers'] as List<String>)
              .map((answers) {
            return Answer(answerQuestion, answers);
          }).toList()
        ],
      ),
    );
  }
}
