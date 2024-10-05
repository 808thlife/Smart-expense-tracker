import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_expenses/data/models/expense.dart';

class ExpenseProvider extends StateNotifier<List<Expense>> {
  ExpenseProvider() : super([]);

  void addExpense(Expense expense) {
    state = [...state, expense];
  }

  void removeExpense(String expenseID) {
    state = state.where((expense) => expense.id != expenseID).toList();
  }
}

final expenseProvider = StateNotifierProvider<ExpenseProvider, List<Expense>>(
  (ref) {
    return ExpenseProvider();
  },
);
