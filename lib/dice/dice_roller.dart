import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hug_app/gradient_container.dart';
import 'package:hug_app/quiz/quiz.dart';

final randomizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  var dice1 = 1;
  var dice2 = 1;
  var dice3 = 1;

  void rollDice() {
    setState(() {
      dice1 = randomizer.nextInt(6) + 1;
      dice2 = randomizer.nextInt(6) + 1;
      dice3 = randomizer.nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GradientContainer(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/dice/dice-$dice1.png',
                    height: isLandscape ? screenWidth * 0.25 : null,
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: Image.asset('assets/images/dice/dice-$dice2.png',
                    height: isLandscape ? screenWidth * 0.25 : null,
                    fit: BoxFit.contain,),
                ),
                Expanded(
                  child: Image.asset('assets/images/dice/dice-$dice3.png',
                    height: isLandscape ? screenWidth * 0.25 : null,
                    fit: BoxFit.contain,),
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: rollDice,
                  style: TextButton.styleFrom(
                    // padding: EdgeInsets.only(top: 100),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 28),
                  ),
                  child: Text('Roll'),
                ),
                SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (ctx) => Quiz()));
                  },
                  style: TextButton.styleFrom(
                    // padding: EdgeInsets.only(top: 100),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 28),
                  ),
                  child: Text('Return'),
                ),
              ],
            ),
          ],
        ),
        colors: [
          Color.fromARGB(255, 138, 138, 144),
          Color.fromARGB(255, 65, 65, 74),
        ],
      ),
    );
  }
}
