import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hug_app/money_tracker/models/expense.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expensive) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  Category _selectedCategory = Category.food;
  DateTime? _selectedDate;

  // var _inputTitle = '';

  // void _changeInputTitle(String title) {
  //   _inputTitle = title;
  // }

  void _submitNewExpense() {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount < 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }
    widget.onAddExpense(
      Expense(
        category: _selectedCategory,
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
      ),
    );
    Navigator.pop(context);
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder:
            (context) => CupertinoAlertDialog(
              title: const Text('Invalid input'),
              content: const Text(
                'Please make sure a valid title, amount, date and category was entered.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Okay'),
                ),
              ],
            ),
      );
    } else {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Invalid input'),
              content: const Text(
                'Please make sure a valid title, amount, date and category was entered.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Okay'),
                ),
              ],
            ),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyBoardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            // physics: const ClampingScrollPhysics(), // << THÊM DÒNG NÀY,
            // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyBoardSpace + 16),
              child: Column(
                children: [
                  // if (width >= 600)
                  //   Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Expanded(
                  //         child: TextField(
                  //           // onChanged: _changeInputTitle,
                  //           controller: _titleController,
                  //           maxLength: 20,
                  //           decoration: InputDecoration(label: Text('Title')),
                  //         ),
                  //       ),
                  //       SizedBox(width: 24),
                  //       Expanded(
                  //         child: TextField(
                  //           // onChanged: _changeInputTitle,
                  //           controller: _amountController,
                  //           keyboardType: TextInputType.number,
                  //           decoration: InputDecoration(
                  //             labelText: 'Amount',
                  //             prefixText: '\$ ',
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   )
                  // else
                  TextField(
                    // onChanged: _changeInputTitle,
                    controller: _titleController,
                    maxLength: 20,
                    decoration: InputDecoration(label: Text('Title')),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          // onChanged: _changeInputTitle,
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Amount',
                            prefixText: '\$ ',
                          ),
                        ),
                      ),
                      // const Spacer(),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _dateController,
                          decoration: InputDecoration(
                            label: Text('select date'),
                            prefixIcon: Icon(Icons.calendar_month),
                          ),
                          readOnly: true,
                          onTap: () async {
                            // FocusScope.of(context).unfocus();
                            //tat ban phim

                            //chờ tới lúc build lại UI xong (sau khi bàn phím đóng) rồi mới thực hiện logic tiếp theo.
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(DateTime.now().year - 10),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                _dateController.text = DateFormat.yMd().format(
                                  pickedDate,
                                );
                                _selectedDate = pickedDate;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DropdownButton<Category>(
                        value: _selectedCategory,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedCategory = value;
                            });
                          }
                        },
                        items:
                            (Category.values.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e.name.toUpperCase()),
                              );
                            }).toList()),
                      ),
                      const Spacer(),

                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _submitNewExpense();
                        },
                        child: Text('Save Expense'),
                      ),
                      // TextField(decoration: InputDecoration(label: Text('Title'))),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
