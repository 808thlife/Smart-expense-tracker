import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

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
  String? id;
  final String? comment;
  final double expense;
  final ExpenseCategory category;

  static const Uuid _uuid = Uuid();

  Expense({
    this.comment,
    required this.expense,
    required this.category,
  })  : timestamp = DateTime.now(),
        id = _uuid.v4();

  String get getDate {
    return DateFormat('MM/dd/yyyy').format(timestamp);
  }
}
