import 'package:flutter/material.dart';
import 'package:hug_app/meal/screens/meal_tab.dart';
import 'package:hug_app/meal/widgets/main_drawer.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;


  @override
  void initState() {
    super.initState();
    _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
    _vegetarianFilterSet = widget.currentFilters[Filter.vegetarian]!;
    _lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
    _veganFilterSet = widget.currentFilters[Filter.vegan]!;


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: MainDrawer(
      //   onSelectDrawer: (idf) {
      //     Navigator.of(context).pop();
      //     if (idf == 'meals') {
      //       Navigator.of(
      //         context,
      //       ).pushReplacement(MaterialPageRoute(builder: (context) => const
      //       MealTab()));
      //     }
      //   },
      // ),
      appBar: AppBar(title: Text('Your Filters')),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegan: _veganFilterSet,
            Filter.vegetarian: _vegetarianFilterSet,
          });
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenFreeFilterSet,
              onChanged: (value) {
                setState(() {
                  _glutenFreeFilterSet = value;
                });
              },
              title: Text(
                'Gluten-free',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onSurface,
                ),
              ),
              subtitle: Text(
                'Only include gluten-free meals.',
                style: Theme
                    .of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onSurface,
                ),
              ),
              activeColor: Theme
                  .of(context)
                  .colorScheme
                  .tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _lactoseFreeFilterSet,
              onChanged: (value) {
                setState(() {
                  _lactoseFreeFilterSet = value;
                });
              },
              title: Text(
                'Lactose-free',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onSurface,
                ),
              ),
              subtitle: Text(
                'Only include lactose-free meals.',
                style: Theme
                    .of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onSurface,
                ),
              ),
              activeColor: Theme
                  .of(context)
                  .colorScheme
                  .tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _vegetarianFilterSet,
              onChanged: (value) {
                setState(() {
                  _vegetarianFilterSet = value;
                });
              },
              title: Text(
                'Vegetarian',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onSurface,
                ),
              ),
              subtitle: Text(
                'Only include vegetarian meals.',
                style: Theme
                    .of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onSurface,
                ),
              ),
              activeColor: Theme
                  .of(context)
                  .colorScheme
                  .tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _veganFilterSet,
              onChanged: (value) {
                setState(() {
                  _veganFilterSet = value;
                });
              },
              title: Text(
                'Vegan',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onSurface,
                ),
              ),
              subtitle: Text(
                'Only include vegan meals.',
                style: Theme
                    .of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onSurface,
                ),
              ),
              activeColor: Theme
                  .of(context)
                  .colorScheme
                  .tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
