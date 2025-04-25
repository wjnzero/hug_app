import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hug_app/meal/models/meal.dart';

class FavouriteNotifier extends StateNotifier<List<Meal>> {
  FavouriteNotifier() : super([]);

  bool toggleMealFavouriteStatus(Meal meal) {
    final mealIsFavourite = state.any((m) => m.id == meal.id);
    if (mealIsFavourite) {
      state = state.where((element) => element.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal.copyWith(isFavourite: true)];
      return true;
    }
  }
}

final favouriteMealsProvider =
    StateNotifierProvider<FavouriteNotifier, List<Meal>>((ref) {
      return FavouriteNotifier();
    });
