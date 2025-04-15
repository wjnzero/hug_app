import 'package:flutter/material.dart';
import 'package:hug_app/money_tracker/models/expense.dart';
import 'package:hug_app/money_tracker/widgets/chart.dart';
import 'package:hug_app/money_tracker/widgets/expenses_list.dart';
import 'package:hug_app/money_tracker/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      category: Category.food,
      title: 'Raw Meat',
      amount: 6.00,
      date: DateTime.now(),
    ),
    Expense(
      category: Category.work,
      title: 'Ak-47',
      amount: 666.66,
      date: DateTime.now(),
    ),
    Expense(
      category: Category.coin,
      title: 'Dca Eth',
      amount: 2000.99,
      date: DateTime(2024),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    Widget mainContent = Center(
      child: const Text('No expenses found, Start adding some!.'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expense: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Money Tracker'),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay, icon: Icon(Icons.add)),
        ],
      ),
      // body: GradientContainer(
      //   Column(
      //     children: [
      //       Chart(expenses: _registeredExpenses,),
      //       Expanded(
      //         child: mainContent,
      //       ),
      //     ],
      //   ),
      //   colors: [
      //     Color.fromARGB(255, 138, 138, 144),
      //     Color.fromARGB(255, 65, 65, 74),
      //   ],
      // ),
      body:
          width < 600
              ? Column(
                children: [
                  Chart(expenses: _registeredExpenses),
                  Expanded(child: mainContent),
                ],
              )
              : Row(
                children: [
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  Expanded(child: mainContent),
                ],
              ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return NewExpense(onAddExpense: _newExpense);
      },
    );
  }

  void _newExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Expense removed.'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }
}
