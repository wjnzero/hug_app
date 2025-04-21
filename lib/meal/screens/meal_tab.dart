import 'package:flutter/material.dart';
import 'package:hug_app/meal/data/dummy_data.dart';
import 'package:hug_app/meal/models/meal.dart';
import 'package:hug_app/meal/screens/filters_screen.dart';
import 'package:hug_app/meal/screens/meal_categories.dart';
import 'package:hug_app/meal/screens/meals_screen.dart';
import 'package:hug_app/meal/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
  Filter.glutenFree: false,
};

class MealTab extends StatefulWidget {
  const MealTab({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MealTabState();
  }
}

class _MealTabState extends State<MealTab> {
  final List<Meal> _favouriteMeals = [];
  int _selectedPageIndex = 0;
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _toggleFavouriteMealIcon(Meal meal) {
    setState(() {
      if (_favouriteMeals.contains(meal)) {
        _favouriteMeals.remove(meal);
        _showInfoMessage('Meal is no longer a favourite.');
      } else {
        Meal mealFav = meal.copyWith(isFavourite: true);
        _favouriteMeals.add(mealFav);
        _showInfoMessage('Meal added to favourites!');
      }
    });
  }

  void _setScreen(String idf) async {
    Navigator.of(context).pop();
    if (idf == 'filters') {
      final res = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => FiltersScreen(currentFilters: _selectedFilters),
        ),
      );
      setState(() {
        _selectedFilters = res ?? kInitialFilters;
      });
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
    final availableMeals =
        dummyMeals.where((element) {
          if (_selectedFilters[Filter.glutenFree]! && !element.isGlutenFree) {
            return false;
          }
          if (_selectedFilters[Filter.lactoseFree]! && !element.isLactoseFree) {
            return false;
          }
          if (_selectedFilters[Filter.vegan]! && !element.isVegan) {
            return false;
          }
          if (_selectedFilters[Filter.vegetarian]! && !element.isVegetarian) {
            return false;
          }
          return true;
        }).toList();
    Widget activePage = MealCategories(
      onToggleFavorite: _toggleFavouriteMealIcon,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favouriteMeals,
        onToggleFavorite: _toggleFavouriteMealIcon,
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
