import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        // Opacity(opacity: 0.5,
        // child: Image.asset('assets/images/quiz/vietcong.png')),
        ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: 0.9,
            child: Image.asset(
              'assets/images/quiz/vietcong.png',
              width: isLandscape ? screenWidth * 0.25 : screenWidth,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Text(
            'Howl666',
            style: GoogleFonts.lato(fontSize: isLandscape ? 16 : 22, color: Colors.white),
          ),
        SizedBox(height: isLandscape ? 5 : 50),
        Padding(
          padding: const EdgeInsets.fromLTRB(0,0,0,20),
          child: OutlinedButton.icon(
              onPressed: startQuiz,
              style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
              label: Text('Connect!'),
              icon: Icon(Icons.arrow_forward_outlined),
            ),
        ),
      ],
    );
  }
}
