import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_expenses/data/hive/expense_crud.dart';
import 'package:smart_expenses/data/models/expense.dart';

class PieChartWidget extends StatefulWidget {
  const PieChartWidget({super.key});

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
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
    int? touchedIndex;
    final data = getWeekdayExpenseSums();
    final nonZeroEntries =
        data.entries.where((entry) => entry.value > 0).toList();

    final sections = nonZeroEntries
        .map((entry) => PieChartSectionData(
              color: _getColor(entry.key),
              value: entry.value,
              title: '', // Remove text from sections
              radius: touchedIndex == _getDayIndex(entry.key) ? 120 : 100,
            ))
        .toList();

    return Container(
      height: 400, // Fixed total height
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = null;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                sectionsSpace: 2,
                centerSpaceRadius: 40,
                sections: sections,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Legend wrapped in a container with fixed height
          Container(
            height: 80, // Fixed height for legend
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 16,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: nonZeroEntries.map((entry) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: _getColor(entry.key),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${entry.key}: \$${entry.value.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor(String day) {
    switch (day) {
      case 'Mon':
        return Theme.of(context).colorScheme.error;
      case 'Tue':
        return Colors.blue;
      case 'Wed':
        return Theme.of(context).colorScheme.primary;
      case 'Thu':
        return const Color.fromARGB(255, 156, 59, 173);
      case 'Fri':
        return const Color.fromARGB(255, 232, 160, 52);
      case 'Sat':
        return const Color.fromARGB(255, 212, 63, 113);
      case 'Sun':
        return const Color.fromARGB(255, 18, 142, 130);
      default:
        return Colors.grey;
    }
  }

  int _getDayIndex(String day) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days.indexOf(day);
  }
}
