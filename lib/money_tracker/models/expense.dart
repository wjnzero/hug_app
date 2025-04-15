import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat('dd/MM/yyyy');

const uuid = Uuid();

enum Category { food, coin, work, health, relax }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.coin: Icons.money,
  Category.work: Icons.work,
  Category.health: Icons.sports_gymnastics,
  Category.relax: Icons.movie,
};

class Expense {
  Expense({
    required this.category,
    required this.title,
    required this.amount,
    required this.date,
  }) : id = uuid.v4();

  Expense.empty()
    : id = uuid.v4(),
      title = '',
      amount = 0.0,
      date = DateTime.now(),
      category = Category.food;

  Expense.catEmpty({Category? cat})
    : id = uuid.v4(),
      title = '',
      amount = 0.0,
      date = DateTime.now(),
      category = cat ?? Category.food;

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
    : expenses =
          allExpenses.where((element) => element.category == category).toList();

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
