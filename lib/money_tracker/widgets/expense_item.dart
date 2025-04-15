import 'package:flutter/material.dart';
import 'package:hug_app/money_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.item, {super.key});

  final Expense item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.title, style: Theme.of(context).textTheme.titleLarge,),
            SizedBox(height: 4,),
            Row(
              children: [
                Text("\$${item.amount.toStringAsFixed(2)}"),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[item.category]),
                    const SizedBox(width: 8,),
                    Text(item.formattedDate),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
