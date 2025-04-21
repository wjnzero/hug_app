import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hug_app/meal/data/dummy_data.dart';
import 'package:hug_app/meal/screens/meal_categories.dart';
import 'package:hug_app/meal/screens/meal_tab.dart';
import 'package:hug_app/meal/screens/meals_screen.dart';
// import 'package:flutter/services.dart';
import 'package:hug_app/quiz/quiz.dart';

// import 'dice/gradient_container.dart';


final mealsTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp
  // ]).then((value) {
  //   runApp(const Quiz());
  // },);
  //chỉ cho phép ứng dụng hiển thị theo hướng dọc (chân dung).
  // debugPaintSizeEnabled = true;

  // runApp(const Quiz());

  runApp(const MealsApp());
}

class MealsApp extends StatelessWidget {
  const MealsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: mealsTheme,
        // home: MealCategories()
        home: MealTab()
        // home: MealsScreen(title: 'title', meals: dummyMeals)
    );
  }
}
