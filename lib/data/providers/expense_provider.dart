import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:smart_expenses/data/models/expense.dart';

class ExpenseProvider extends StateNotifier<List<Expense>> {
  ExpenseProvider() : super([]) {
    loadExpenses();
  }

  void addExpense(Expense expense) {
    state = [...state, expense];
  }

  //Loads initial data from Hive.
  Future<void> loadExpenses() async {
    final box = await Hive.openBox<Expense>('expenses');
    state = box.values.toList(); // Load expenses into the state
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
