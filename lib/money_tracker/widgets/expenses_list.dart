import 'package:flutter/material.dart';
import 'package:hug_app/money_tracker/models/expense.dart';
import 'package:hug_app/money_tracker/widgets/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expense,
    required this.onRemoveExpense,
  });

  final List<Expense> expense;
  final void Function(Expense expense ) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expense.length,
      itemBuilder:
          (context, index) => Dismissible(
            key: ValueKey(expense[index]),
            onDismissed: (direction) {
              onRemoveExpense(expense[index]);
            },
            child: ExpenseItem(expense[index]),
          ),
    );
  }
}
