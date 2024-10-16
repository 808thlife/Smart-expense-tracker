import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:smart_expenses/data/hive/expense_crud.dart';
import 'package:smart_expenses/data/models/expense.dart';
import 'package:smart_expenses/data/providers/expense_provider.dart';

class WeeklyChart extends ConsumerStatefulWidget {
  const WeeklyChart({super.key});

  @override
  ConsumerState<WeeklyChart> createState() => _WeeklyChartState();
}

class _WeeklyChartState extends ConsumerState<WeeklyChart> {
  List<DateTime> getCurrentWeekDays() {
    DateTime now = DateTime.now();
    int currentDay = now.weekday;
    DateTime startOfWeek = now.subtract(Duration(days: currentDay - 1));

    // Generate the list of week days, setting the time to midnight (00:00:00)
    List<DateTime> weekDays = List.generate(7, (index) {
      DateTime day = startOfWeek.add(Duration(days: index));
      return DateTime(day.year, day.month, day.day); // Keeps only the date
    });

    return weekDays;
  }

  List<Expense> getWeeklyExpenses() {
    final hiveManager = ExpenseManager();
    final currentDays = getCurrentWeekDays();
    final allExpenses = hiveManager.getExpenses();

    final filteredExpenses = allExpenses.where((expense) {
      DateTime expenseDate = DateTime(
        expense.timestamp.year,
        expense.timestamp.month,
        expense.timestamp.day,
      );

      // Use 'any' to check if the date matches any of the current week days
      return currentDays.any((day) =>
          day.year == expenseDate.year &&
          day.month == expenseDate.month &&
          day.day == expenseDate.day);
    }).toList();

    return filteredExpenses;
  }

  Map<String, double> getWeekdayExpenseSums() {
    final expenses = getWeeklyExpenses();
    final currentDays = getCurrentWeekDays();
    log(expenses.toString());
    log(currentDays.toString());

    // Initialize a map to store total expenses for each day
    Map<String, double> weeklyExpenseSums = {
      for (DateTime day in currentDays) DateFormat.E().format(day): 0.0
    };

    // Iterate over expenses and sum them up by weekday
    for (Expense expense in expenses) {
      String day = DateFormat.E()
          .format(expense.timestamp); // Get short day name, e.g., Mon
      weeklyExpenseSums[day] =
          (weeklyExpenseSums[day] ?? 0.0) + expense.expense;
    }

    return weeklyExpenseSums;
  }

  @override
  Widget build(BuildContext context) {
    final weeklies = getWeekdayExpenseSums();
    log(weeklies.toString());
    return SizedBox();
  }
}
