import 'package:flutter/material.dart';
import 'package:hug_app/dice/dice_roller.dart';
import 'package:hug_app/money_tracker/expenses.dart';
import 'package:hug_app/quiz/data/question.dart';
import 'package:hug_app/quiz/questions_summary.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.chosenAnswers,
    required this.restartQuiz, required this.nextButton,
  });

  final List<String> chosenAnswers;

  // final Widget buttonNext;
  final void Function() restartQuiz;
  final void Function() nextButton;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];
    for (int i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': question[i].text,
        'correct_answer': question[i].answer[0],
        'user_answer': chosenAnswers[i],
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numQuestions = question.length;
    final numCorrectQuestions =
        summaryData.where((element) {
          return element['user_answer'] == element['correct_answer'];
        }).length;
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $numCorrectQuestions out of $numQuestions questions correctly!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 30),
            // Text('List of answers and questions...'),
            QuestionsSummary(summaryData: getSummaryData()),
            SizedBox(height: 30),
            Expanded(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  OutlinedButton.icon(
                    onPressed: restartQuiz,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    label: Text('Retry!'),
                    icon: Icon(Icons.restart_alt_outlined),
                  ),
                  OutlinedButton.icon(
                    onPressed:
                    numCorrectQuestions == numQuestions ? () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => DiceRoller()),
                      );
                    } : null,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    label: Text('Play Dice!'),
                    icon: Icon(Icons.play_arrow),
                  ),
                  OutlinedButton.icon(
                    onPressed:
                    numCorrectQuestions == numQuestions ? () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => Expenses()),
                      );
                    } : null,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    label: Text('Money Tracker'),
                    icon: Icon(Icons.play_arrow),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
