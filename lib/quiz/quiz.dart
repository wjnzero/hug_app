import 'package:flutter/material.dart';
import 'package:hug_app/quiz/data/question.dart';
import 'package:hug_app/quiz/question_screen.dart';
import 'package:hug_app/quiz/result_screen.dart';
import 'package:hug_app/quiz/start_screen.dart';

import '../gradient_container.dart';
import '../money_tracker/expenses.dart';

const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 255, 254, 248),
);
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 8, 9, 9),
);

class Quiz extends StatefulWidget {
  const Quiz({super.key});


  @override
  StatefulElement createElement() {
    print('hug_app createElement');
    return super.createElement();
  }

  @override
  State<StatefulWidget> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];

  // Widget? activeScreen;
  var activeScreen = 'start_screen';

  // @override
  // void initState() {
  //   super.initState();
  //   activeScreen = StartScreen(switchScreen);
  // }

  void switchScreen() {
    setState(() {
      activeScreen = 'question-screen';
    });
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'questions-screen';
    });
  }

  void playDice() {
    setState(() {
      selectedAnswers = [];
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);
    setState(() {
      if (selectedAnswers.length == question.length) {
        // activeScreen = StartScreen(switchScreen);
        // activeScreen = 'start-screen';
        activeScreen = 'result-screen';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('hug_app build Widget');
    Widget? screenWidget;
    if (activeScreen == 'start_screen') {
      screenWidget = StartScreen(switchScreen);
    }
    if (activeScreen == 'question-screen') {
      screenWidget = QuestionScreen(onSelectAnswer: chooseAnswer);
    }
    if (activeScreen == 'result-screen') {
      screenWidget = ResultScreen(
        chosenAnswers: selectedAnswers,
        restartQuiz: restartQuiz,
        nextButton: playDice,
      );
    }

    // if (activeScreen == 'money-tracker-screen') {
    //   screenWidget = DiceRoller(backFunction: restartQuiz,);
    // }
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        cardTheme: CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.primaryContainer,
          foregroundColor: kColorScheme.onPrimaryContainer,
        ),
        cardTheme: CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: kColorScheme.onSecondaryContainer,
            fontSize: 16,
          ),
        ),
      ),
      themeMode: ThemeMode.system,

      home: Scaffold(
        // backgroundColor: Color.fromARGB(255, 138, 138, 144),
        // appBar:
        //     (screenWidget is Expenses)
        //         ? AppBar(
        //       title: Text('Money Tracker'),
        //       // backgroundColor: Colors.deepPurple,
        //           actions: [
        //             IconButton(onPressed: (){}, icon: Icon(Icons.add)),
        //           ],
        //         )
        //         : null,
        body: GradientContainer(
          screenWidget,
          colors: [
            Color.fromARGB(255, 138, 138, 144),
            Color.fromARGB(255, 65, 65, 74),
          ],
        ),
      )
      // home: Expenses(),
    );
  }
}
