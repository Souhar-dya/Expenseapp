// ignore: file_names
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var formatter = DateFormat('dd/MM/yyyy');

enum Category { food, work, travel, miscellaneous }

final categoryIcons = {
  Category.food: Icons.lunch_dining_rounded,
  Category.miscellaneous: Icons.request_quote_sharp,
  Category.travel: Icons.pedal_bike_sharp,
  Category.work: Icons.work
};

class Expenses {
  const Expenses(
      {required this.title,
      required this.amount,
      required this.shop,
      required this.category,
      required this.date});
  final String title;
  final double amount;
  final DateTime date;
  final String shop;
  final Category category;

  String get formattedDate => formatter.format(date);
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});
  final List<Expenses> expenses;
  final Category category;

  ExpenseBucket.forCategory(List<Expenses> allExpenses, this.category)
      : expenses = allExpenses
            .where((element) => element.category == category)
            .toList();

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
