import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:smart_expenses/data/hive/expense_crud.dart';
import 'package:smart_expenses/data/models/expense.dart';

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
    int? touchedIndex;
    final weeklies = getWeekdayExpenseSums();
    log(weeklies.toString());
    return AspectRatio(
      aspectRatio: 1.6,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: weeklies.values.reduce((a, b) => a > b ? a : b),
            barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  String weekDay = weeklies.keys.toList()[group.x.toInt()];
                  return BarTooltipItem(
                    '$weekDay\n',
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: '\$${rod.toY.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.yellow,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  );
                },
              ),
              touchCallback:
                  (FlTouchEvent event, BarTouchResponse? touchResponse) {
                setState(() {
                  if (event is FlTapUpEvent) {
                    touchedIndex = touchResponse?.spot?.touchedBarGroupIndex;
                    if (touchedIndex != null) {
                      String selectedDay =
                          weeklies.keys.elementAt(touchedIndex!);
                      double amount = weeklies.values.elementAt(touchedIndex!);
                      log('Bar clicked: $selectedDay - \$${amount.toStringAsFixed(2)}');
                      // Add your click handling logic here
                    }
                  } else {
                    touchedIndex = -1;
                  }
                });
              },
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    List<String> days = weeklies.keys.toList();
                    if (value >= 0 && value < days.length) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          days[value.toInt()],
                          style: const TextStyle(fontSize: 12),
                        ),
                      );
                    }
                    return const Text('');
                  },
                  reservedSize: 30,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  interval: 200,
                  maxIncluded: false,
                  minIncluded: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    return Text(
                      '\$${value.toInt()}',
                      style: const TextStyle(fontSize: 10),
                    );
                  },
                ),
              ),
              topTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(show: false),
            gridData: const FlGridData(show: false),
            barGroups: weeklies.entries.map((entry) {
              int x = weeklies.keys.toList().indexOf(entry.key);
              return BarChartGroupData(
                x: x,
                barRods: [
                  BarChartRodData(
                    toY: entry.value,
                    color: touchedIndex == x
                        ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
                        : Theme.of(context).colorScheme.primary,
                    width: 20,
                  )
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
