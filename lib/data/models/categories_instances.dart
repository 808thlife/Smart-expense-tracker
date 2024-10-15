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
    color: const Color.fromARGB(255, 40, 33, 243),
    category: ExpenseCategoryEnum.transportation,
    icon: const Icon(HugeIcons.strokeRoundedCar01),
  ),
  ExpenseCategory(
    color: const Color.fromARGB(255, 170, 22, 187),
    category: ExpenseCategoryEnum.services,
    icon: const Icon(HugeIcons.strokeRoundedService),
  ),
  ExpenseCategory(
    color: const Color.fromARGB(255, 7, 120, 60),
    category: ExpenseCategoryEnum.streamings,
    icon: const Icon(HugeIcons.strokeRoundedSpotify),
  ),
  ExpenseCategory(
    color: const Color.fromARGB(255, 222, 151, 19),
    category: ExpenseCategoryEnum.other,
    icon: const Icon(HugeIcons.strokeRoundedQuestion),
  ),
];

// A function to return the correct category details based on the enum
ExpenseCategory getCategoryDetails(ExpenseCategoryEnum categoryEnum) {
  return categories.firstWhere((category) => category.category == categoryEnum);
}
