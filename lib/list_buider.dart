import 'package:expense/datamodel/Expenses.dart';
import 'package:expense/expense_card.dart';
import 'package:flutter/material.dart';

class ListOfExpenses extends StatelessWidget {
  const ListOfExpenses(
      {super.key, required this.expenses, required this.onRemove});
  final void Function(Expenses expense) onRemove;
  final List<Expenses> expenses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) => Dismissible(
            onDismissed: (direction) => onRemove(expenses[index]),
            key: ValueKey(expenses[index]),
            child: ExpenseCard(expense: expenses[index])));
  }
}
