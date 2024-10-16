import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

part 'expense.g.dart';

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

class ExpenseCategory {
  final Color color;

  final Icon icon;

  final ExpenseCategoryEnum category;

  ExpenseCategory(
      {required this.color, required this.category, required this.icon});
}

@HiveType(typeId: 2)
class Expense extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late DateTime timestamp;

  @HiveField(2)
  late String title;

  @HiveField(3)
  late String? comment;

  @HiveField(4)
  late double expense;

  @HiveField(5)
  late ExpenseCategoryEnum category;

  static const Uuid _uuid = Uuid();

  Expense(
      {this.comment,
      required this.expense,
      required this.category,
      required this.title,
      required this.timestamp}) {
    id = _uuid.v4();
  }

  String get getDate {
    return DateFormat('MM/dd/yyyy').format(timestamp);
  }
}
