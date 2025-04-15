import 'package:flutter/material.dart';
// import 'package:hug_app/quiz/start_screen.dart';

// import 'dice_roller.dart';
// import 'package:hug_app/styled_text.dart';

const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;

class GradientContainer extends StatelessWidget {

  const GradientContainer(this.activeScreen, {super.key, required this.colors});

  final List<Color> colors;

  final Widget? activeScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: startAlignment,
          end: endAlignment,
        ),
      ),
      child: Center(
        // child: StyledText('Wjnzero!'),
        // child: DiceRoller()
        child: activeScreen,

      ),
    );
  }
}

