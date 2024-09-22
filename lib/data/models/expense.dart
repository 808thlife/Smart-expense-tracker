import 'dart:ui';

enum ExpenseCategory {
  leisure,
  transportation,
  cafe,
  services,
  streamings,
  other
}

class Expense {
  final Color color;
  final DateTime timestamp;
  final String name;
  final double expense;
  final ExpenseCategory category;

  Expense(
      {required this.color,
      required this.name,
      required this.expense,
      required this.category})
      : timestamp = DateTime.now();
}
