import 'package:flutter/material.dart';
import 'package:smart_expenses/data/models/expense.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Text(
      expense.expense.toString(),
    );
  }
}
