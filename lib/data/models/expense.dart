import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

part 'expense_model.g.dart';

@HiveType(typeId: 0)
enum ExpenseCategoryEnum {
  @HiveField(0)
  leisure,

  @HiveField(1)
  transportation,

  @HiveField(2)
  cafe,

  @HiveField(3)
  services,

  @HiveField(4)
  streamings,

  @HiveField(5)
  other
}

@HiveType(typeId: 1)
class ExpenseCategory {
  @HiveField(0)
  final Color color;

  @HiveField(1)
  final Icon icon;

  @HiveField(2)
  final ExpenseCategoryEnum category;

  ExpenseCategory(
      {required this.color, required this.category, required this.icon});
}

@HiveType(typeId: 2)
class Expense {
  final DateTime timestamp;
  String? id;
  final String title;
  final String? comment;
  final double expense;
  final ExpenseCategory category;

  static const Uuid _uuid = Uuid();

  Expense({
    this.comment,
    required this.expense,
    required this.category,
    required this.title,
  })  : timestamp = DateTime.now(),
        id = _uuid.v4();

  String get getDate {
    return DateFormat('MM/dd/yyyy').format(timestamp);
  }
}
