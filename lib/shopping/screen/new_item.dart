import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hug_app/shopping/data/categories.dart';
import 'package:hug_app/shopping/models/category.dart';
import 'package:hug_app/shopping/models/grocery_Item.dart';

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({super.key});

  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enterName = '';
  var _enterQuantity = 1;
  var _selectCategory = categories[Categories.other];
  var _isSending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add new item')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: InputDecoration(label: Text("Name")),
                validator: (value) {
                  return value == null ||
                          value.isEmpty ||
                          value.trim().length <= 1 ||
                          value.trim().length > 50
                      ? 'Must be between 2 and 50 characters.'
                      : null;
                },
                onSaved: (newValue) {
                  _enterName = newValue!;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: '1',
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(label: Text("Quantity")),
                      validator: (value) {
                        return value == null ||
                                value.isEmpty ||
                                int.tryParse(value) == null ||
                                int.tryParse(value)! <= 0
                            ? 'Must be a valid, positive number.'
                            : null;
                      },
                      onSaved: (newValue) {
                        _enterQuantity = int.parse(newValue!);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _selectCategory,
                      items:
                          categories.entries.map((e) {
                            return DropdownMenuItem(
                              value: e.value,
                              child: Row(
                                children: [
                                  Container(
                                    width: 16,
                                    height: 16,
                                    color: e.value.color,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(e.value.title),
                                ],
                              ),
                            );
                          }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectCategory = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed:
                        _isSending
                            ? null
                            : () {
                              _formKey.currentState!.reset();
                            },
                    child: const Text('Clear'),
                  ),
                  ElevatedButton(
                    onPressed:
                        _isSending
                            ? null
                            : () {
                              _saveItem();
                            },
                    child:
                        _isSending
                            ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(),
                            )
                            : const Text('Add Item'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSending = true;
      });
      _formKey.currentState!.save();
      final url = Uri.https(
        'hug-app-cbce6-default-rtdb.asia-southeast1.firebasedatabase.app',
        'shopping-list.json',
      );
      final res = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': _enterName,
          'quantity': _enterQuantity,
          'category': _selectCategory!.title,
        }),
      );

      // res.statusCode == 200
      if (!context.mounted) {
        return;
      }
      final Map<String, dynamic> resData = json.decode(res.body);

      // Navigator.of(context).pop();

      Navigator.of(context).pop(
        GroceryItem(
          id: resData['name'],
          name: _enterName,
          quantity: _enterQuantity,
          category: _selectCategory!,
        ),
      );
    }
  }
}
