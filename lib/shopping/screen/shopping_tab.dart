import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:hug_app/shopping/data/categories.dart';
import 'package:hug_app/shopping/models/grocery_Item.dart';
import 'package:hug_app/shopping/screen/new_item.dart';

class ShoppingTab extends ConsumerStatefulWidget {
  const ShoppingTab({super.key});

  @override
  ConsumerState<ShoppingTab> createState() => _ShoppingTabState();
}

class _ShoppingTabState extends ConsumerState<ShoppingTab> {
  List<GroceryItem> _groceryItems = [];
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    // _groceryItems = ref.read(groceryProvider);
    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(child: Text('No items added yet.'));

    if (_isLoading) {
      content = Center(child: CircularProgressIndicator());
    }
    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(_groceryItems[index].id),
            onDismissed: (direction) {
              _removeItem(_groceryItems[index]);
            },
            child: ListTile(
              title: Text(_groceryItems[index].name),
              leading: Container(
                width: 24,
                height: 24,
                color: _groceryItems[index].category.color,
              ),
              trailing: Text(_groceryItems[index].quantity.toString()),
            ),
          );
        },
        itemCount: _groceryItems.length,
      );
    }
    return Scaffold(
      body: content,

      appBar: AppBar(
        title: Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: () {
              _addItem();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  void _loadItems() async {
    final url = Uri.https(
      'hug-app-cbce6-default-rtdb.asia-southeast1.firebasedatabase.app',
      'shopping-list.json',
    );
    final res = await http.get(url);
    final Map<String, dynamic> listData = json.decode(res.body);
    final List<GroceryItem> _loadItems = [];

    for (final item in listData.entries) {
      final category =
          categories.entries
              .firstWhere(
                (catItem) =>
                    catItem.value.title.contains(item.value['category']),
              )
              .value;
      _loadItems.add(
        GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        ),
      );
    }
    setState(() {
      _groceryItems = _loadItems;
      _isLoading = false;
    });
    print(res.body);
  }

  void _addItem() async {
    // final newItem =
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (context) => const NewItemScreen()),
    );
    // if(newItem == null) {
    //   return;
    // }
    //
    // _loadItems();

    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) {
    setState(() {
      _groceryItems.remove(item);
    });
  }
}
