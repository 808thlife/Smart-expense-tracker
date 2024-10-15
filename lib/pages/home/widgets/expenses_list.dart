import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_expenses/data/hive/expense_crud.dart';
import 'package:smart_expenses/data/providers/expense_provider.dart';
import 'package:smart_expenses/pages/home/widgets/expense_card.dart';

class ExpensesList extends ConsumerStatefulWidget {
  const ExpensesList({super.key});

  @override
  ConsumerState<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends ConsumerState<ExpensesList> {
  @override
  Widget build(BuildContext context) {
    final expenseManagerInstance = ExpenseManager();
    final expensesListHive = expenseManagerInstance.getExpenses();
    return ListView.builder(
      itemCount: expensesListHive.length,
      itemBuilder: (context, index) => ExpenseCard(
        expense: expensesListHive[index],
      ),
    );
  }
}
