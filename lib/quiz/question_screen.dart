import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hug_app/quiz/answer_button.dart';
import 'package:hug_app/quiz/data/question.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionScreen> createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  var countQuestion = 0;

  void answerQuestion(String answer) {
    widget.onSelectAnswer(answer);
    setState(() {
      countQuestion++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = question[countQuestion];
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              textAlign: TextAlign.center,
              currentQuestion.text,
              style: GoogleFonts.lato(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ...currentQuestion.getShuffledAnswer().map((item) {
              return AnswerButton(answerText: item, onTap: (){
                answerQuestion(item);
              });
            }),
          ],
        ),
      ),
    );
  }
}
