import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hug_app/meal/models/meal.dart';
import 'package:hug_app/meal/providers/favourite_provider.dart';
import 'package:hug_app/meal/providers/meals_provider.dart';
import 'package:hug_app/meal/screens/filters_screen.dart';
import 'package:hug_app/meal/screens/meal_categories.dart';
import 'package:hug_app/meal/screens/meals_screen.dart';
import 'package:hug_app/meal/widgets/main_drawer.dart';

import '../providers/filters_provider.dart';

const kInitialFilters = {
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
  Filter.glutenFree: false,
};

class MealTab extends ConsumerStatefulWidget {
  const MealTab({super.key});

  @override
  ConsumerState<MealTab> createState() {
    return _MealTabState();
  }
}

class _MealTabState extends ConsumerState<MealTab> {
  // final List<Meal> _favouriteMeals = [];
  int _selectedPageIndex = 0;

  // Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  // void _toggleFavouriteMealIcon(Meal meal) {
  //   setState(() {
  //     if (_favouriteMeals.contains(meal)) {
  //       _favouriteMeals.remove(meal);
  //       _showInfoMessage('Meal is no longer a favourite.');
  //     } else {
  //       Meal mealFav = meal.copyWith(isFavourite: true);
  //       _favouriteMeals.add(mealFav);
  //       _showInfoMessage('Meal added to favourites!');
  //     }
  //   });
  // }

  void _setScreen(String idf) async {
    Navigator.of(context).pop();
    if (idf == 'filters') {
      final res = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => FiltersScreen(
              // currentFilters: _selectedFilters
          ),
        ),
      );
      // setState(() {
      //   _selectedFilters = res ?? kInitialFilters;
      // });
    }
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
        // action: SnackBarAction(
        //   label: 'Undo',
        //   onPressed: () {
        //     setState(() {
        //       _registeredExpenses.insert(expenseIndex, message);
        //     });
        //   },
        // ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final activeFilters = ref.watch(filtersProvider);
    // final mealDump = ref.watch(mealProvider);
    // final availableMeals =
    //     ref.watch(mealProvider).where((element) {
    //       if (activeFilters[Filter.glutenFree]! && !element.isGlutenFree) {
    //         return false;
    //       }
    //       if (activeFilters[Filter.lactoseFree]! && !element.isLactoseFree) {
    //         return false;
    //       }
    //       if (activeFilters[Filter.vegan]! && !element.isVegan) {
    //         return false;
    //       }
    //       if (activeFilters[Filter.vegetarian]! && !element.isVegetarian) {
    //         return false;
    //       }
    //       return true;
    //     }).toList();

    final availableMeals = ref.watch(filteredMealsProvider);
    Widget activePage = MealCategories(
      // onToggleFavorite: _toggleFavouriteMealIcon,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favouriteMeals = ref.watch(favouriteMealsProvider);
      activePage = MealsScreen(
        meals: favouriteMeals,
        // onToggleFavorite: _toggleFavouriteMealIcon,
      );
      activePageTitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      body: activePage,
      drawer: MainDrawer(onSelectDrawer: _setScreen),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
