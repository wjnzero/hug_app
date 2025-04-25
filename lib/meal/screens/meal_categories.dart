import 'package:flutter/material.dart';
import 'package:hug_app/meal/data/dummy_data.dart';
import 'package:hug_app/meal/models/category.dart';
import 'package:hug_app/meal/screens/meals_screen.dart';
import 'package:hug_app/meal/widgets/category_grid_item.dart';

import '../models/meal.dart';

class MealCategories extends StatelessWidget {
  const MealCategories({
    super.key,
    // required this.onToggleFavorite,
    required this.availableMeals,
  });

  // final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeal =
        availableMeals
            .where((meal) => meal.categories.contains(category.id))
            .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (context) => MealsScreen(
              title: category.title,
              meals: filteredMeal,
              // onToggleFavorite: onToggleFavorite,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 3 / 2,
      ),
      children: [
        // for (final ctg in availableCategories)
        //   CategoryGridItem(category: ctg),
        ...availableCategories.map(
          (ctg) => CategoryGridItem(
            category: ctg,
            onSelect: () {
              _selectCategory(context, ctg);
            },
          ),
        ),
      ],
    );
  }
}
