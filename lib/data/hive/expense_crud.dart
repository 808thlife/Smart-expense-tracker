import 'package:hive/hive.dart';
import 'package:smart_expenses/data/models/expense.dart';

class ExpenseManager {
  void addExpense(Expense expense) async {
    var box = await Hive.openBox<Expense>('expense');
    await box.add(expense);
  }

  void removeExpense(String expenseID) async {
    var box = await Hive.openBox<Expense>('expense');
    final Map<dynamic, Expense> expensesMap = box.toMap();
    dynamic desiredKey;
    expensesMap.forEach((key, value) {
      if (value.id == expenseID) {
        desiredKey = key;
      }
    });
    await box.delete(desiredKey);
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
