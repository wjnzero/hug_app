import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/filters_provider.dart';

// enum Filter {
//   glutenFree,
//   lactoseFree,
//   vegetarian,
//   vegan,
// }

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    super.key,
    // required this.currentFilters
  });

  // final Map<Filter, bool> currentFilters;

  //   @override
  //   ConsumerState<FiltersScreen> createState() {
  //     return _FiltersScreenState();
  //   }
  // }
  //
  // class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  //   var _glutenFreeFilterSet = false;
  //   var _lactoseFreeFilterSet = false;
  //   var _vegetarianFilterSet = false;
  //   var _veganFilterSet = false;

  // @override
  // void initState() {
  //   super.initState();
  //   final initFilters = ref.read(filtersProvider);
  //   _glutenFreeFilterSet = initFilters[Filter.glutenFree]!;
  //   _vegetarianFilterSet = initFilters[Filter.vegetarian]!;
  //   _lactoseFreeFilterSet = initFilters[Filter.lactoseFree]!;
  //   _veganFilterSet = initFilters[Filter.vegan]!;
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
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
        canPop: true,
        // canPop: false,
        // onPopInvokedWithResult: (didPop, result) {
        //   ref.read(filtersProvider.notifier).setFilters({
        //     Filter.glutenFree: _glutenFreeFilterSet,
        //     Filter.lactoseFree: _lactoseFreeFilterSet,
        //     Filter.vegan: _veganFilterSet,
        //     Filter.vegetarian: _vegetarianFilterSet,
        //   });
        //   if (didPop) return;
        //   Navigator.of(context).pop();
        //   // Navigator.of(context).pop(
        //   //     {
        //   //   Filter.glutenFree: _glutenFreeFilterSet,
        //   //   Filter.lactoseFree: _lactoseFreeFilterSet,
        //   //   Filter.vegan: _veganFilterSet,
        //   //   Filter.vegetarian: _vegetarianFilterSet,
        //   // }
        //   // );
        // },
        child: Column(
          children: [
            SwitchListTile(
              // value: _glutenFreeFilterSet,
              value: activeFilters[Filter.glutenFree]!,
              onChanged: (value) {
                // setState(() {
                //   _glutenFreeFilterSet = value;
                // });
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.glutenFree, value);
              },
              title: Text(
                'Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Only include gluten-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              // value: _lactoseFreeFilterSet,
              value: activeFilters[Filter.lactoseFree]!,
              onChanged: (value) {
                // setState(() {
                //   _lactoseFreeFilterSet = value;
                // });
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.lactoseFree, value);
              },
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Only include lactose-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              // value: _vegetarianFilterSet,
              value: activeFilters[Filter.vegetarian]!,
              onChanged: (value) {
                // setState(() {
                //   _vegetarianFilterSet = value;
                // });
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.vegetarian, value);
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Only include vegetarian meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              // value: _veganFilterSet,
              value: activeFilters[Filter.vegan]!,
              onChanged: (value) {
                // setState(() {
                //   _veganFilterSet = value;
                // });
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.vegan, value);
              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Only include vegan meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
