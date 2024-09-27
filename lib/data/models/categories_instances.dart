import 'package:flutter/material.dart';
import 'package:smart_expenses/data/models/expense.dart';
import 'package:hugeicons/hugeicons.dart';

final categories = [
  ExpenseCategory(
    color: Colors.blue,
    category: ExpenseCategoryEnum.cafe,
    icon: const Icon(HugeIcons.strokeRoundedRestaurant01),
  ),
  ExpenseCategory(
    color: const Color.fromARGB(255, 88, 238, 210),
    category: ExpenseCategoryEnum.leisure,
    icon: const Icon(HugeIcons.strokeRoundedBeach),
  ),
  ExpenseCategory(
    color: Colors.blue,
    category: ExpenseCategoryEnum.transportation,
    icon: const Icon(HugeIcons.strokeRoundedCar01),
  ),
  ExpenseCategory(
    color: Colors.blue,
    category: ExpenseCategoryEnum.services,
    icon: const Icon(HugeIcons.strokeRoundedService),
  ),
  ExpenseCategory(
    color: Colors.blue,
    category: ExpenseCategoryEnum.streamings,
    icon: const Icon(HugeIcons.strokeRoundedSpotify),
  ),
  ExpenseCategory(
    color: Colors.blue,
    category: ExpenseCategoryEnum.other,
    icon: const Icon(HugeIcons.strokeRoundedQuestion),
  ),
];
