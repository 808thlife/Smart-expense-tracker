import 'package:hive/hive.dart';
import 'package:smart_expenses/data/models/expense.dart';

class ExpenseManager {
  void addExpense(Expense expense) async {
    var box = await Hive.openBox<Expense>('expense');
    await box.add(expense);
  }

  void removeExpense(Expense expense) async {
    var box = await Hive.openBox<Expense>('expense');
    await box.delete(expense);
  }

  List<Expense> getExpenses() {
    var box = Hive.box<Expense>('expense');
    List<Expense> expenses = box.values.toList();
    return expenses;
  }

  Expense getExpenseById(String id) {
    var box = Hive.box<Expense>('expense');
    final expense = box.values.firstWhere((expense) => expense.id == id);
    return expense;
  }
}
