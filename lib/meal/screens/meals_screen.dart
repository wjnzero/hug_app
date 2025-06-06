import 'package:flutter/material.dart';
import 'package:hug_app/meal/models/meal.dart';
import 'package:hug_app/meal/widgets/meal_item.dart';

import 'meal_details.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, this.title, required this.meals,
    // required this.onToggleFavorite
  });

  final String? title;
  final List<Meal> meals;
  // final void Function(Meal meal) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh oh ... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Try selecting a different category!',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder:
            (context, index) => MealItem(
              meal: meals[index],
              onSelectMeal: (meal) {
                selectMeal(context, meal);
              }, onSelectFavouriteIcon: (Meal meal) {

            },
            ),
        //     Text(
        //   meals[index].title,
        //   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        //     color: Theme.of(context).colorScheme.onSurface,
        //   ),
        // ),
      );
    }
    return title == null
        ? content
        : Scaffold(appBar: AppBar(title: Text(title!)), body: content);
  }

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => MealDetails(meal: meal,
    // onToggleFavorite: onToggleFavorite,
    )));
  }
}
