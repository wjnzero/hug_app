import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hug_app/meal/screens/meal_tab.dart';
import 'package:hug_app/quiz/quiz.dart';
import 'package:hug_app/shopping/screen/shopping_tab.dart';

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

  // runApp(ProviderScope(child: const Quiz()));
  runApp(ProviderScope(child: const ShoppingApp()));

  // runApp(ProviderScope(child: const MealsApp()));
}

class MealsApp extends StatelessWidget {
  const MealsApp({super.key});

   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: mealsTheme,
      // home: MealCategories()
      home: MealTab(),
      // home: MealsScreen(title: 'title', meals: dummyMeals)
    );
  }
}


class ShoppingApp extends StatelessWidget{
  const ShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Groceries',
      theme: ThemeData.dark().copyWith(
        // useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 147, 229, 250),
          brightness: Brightness.dark,
          surface: const Color.fromARGB(255, 42, 51, 59),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 50, 58, 60),
      ),
      home: ShoppingTab(),
    );
  }

}

