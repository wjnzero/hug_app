import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hug_app/shopping/models/grocery_Item.dart';
import 'package:hug_app/shopping/provider/grocery_provider.dart';
import 'package:hug_app/shopping/screen/new_item.dart';

class ShoppingTab extends ConsumerStatefulWidget {
  const ShoppingTab({super.key});

  @override
  ConsumerState<ShoppingTab> createState() => _ShoppingTabState();
}

class _ShoppingTabState extends ConsumerState<ShoppingTab> {
  late List<GroceryItem> _groceryItems = [];

  @override
  void initState() {
    super.initState();
    _groceryItems = ref.read(groceryProvider);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(child: Text('No items added yet.'));
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

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (context) => const NewItemScreen()),
    );
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
