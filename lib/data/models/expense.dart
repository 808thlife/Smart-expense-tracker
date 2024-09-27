import 'dart:ui';

import 'package:flutter/material.dart';

enum ExpenseCategoryEnum {
  leisure,
  transportation,
  cafe,
  services,
  streamings,
  other
}

class ExpenseCategory {
  final Color color;
  final Icon icon;
  final ExpenseCategoryEnum category;

  ExpenseCategory(
      {required this.color, required this.category, required this.icon});
}

class Expense {
  final DateTime timestamp;
  final String? comment;
  final double expense;
  final ExpenseCategory category;

  Expense({
    this.comment,
    required this.expense,
    required this.category,
  }) : timestamp = DateTime.now();
}
