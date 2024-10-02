import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:smart_expenses/constants/date_filters.dart';
import 'package:smart_expenses/data/models/expense.dart';
import 'package:smart_expenses/data/providers/expense_provider.dart';

class DateCategories extends ConsumerStatefulWidget {
  const DateCategories({super.key});

  @override
  _DateCategoriesState createState() => _DateCategoriesState();
}

class _DateCategoriesState extends ConsumerState<DateCategories> {
  DateFilter? _selectedDateFilter;

  // Method to filter expenses based on the selected date range
  List<Expense> _filterExpenses(DateFilter? filter) {
    final expenses = ref.watch(expenseProvider);
    if (filter == null) return expenses;

    DateTime now = DateTime.now();

    switch (filter) {
      case DateFilter.today:
        return expenses
            .where((expense) =>
                DateFormat('yyyy-MM-dd').format(expense.timestamp) ==
                DateFormat('yyyy-MM-dd').format(now))
            .toList();
      case DateFilter.thisWeek:
        DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        return expenses
            .where((expense) =>
                expense.timestamp.isAfter(startOfWeek) &&
                expense.timestamp.isBefore(now.add(Duration(days: 1))))
            .toList();
      case DateFilter.thisMonth:
        return expenses
            .where((expense) =>
                expense.timestamp.month == now.month &&
                expense.timestamp.year == now.year)
            .toList();
      default:
        return expenses;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          DropdownButton<DateFilter>(
            value: _selectedDateFilter,
            hint: const Text('Select Date Range'),
            items: DateFilter.values.map((DateFilter filter) {
              return DropdownMenuItem<DateFilter>(
                value: filter,
                child: Text(filter == DateFilter.today
                    ? 'Today'
                    : filter == DateFilter.thisWeek
                        ? 'This Week'
                        : 'This Month'),
              );
            }).toList(),
            onChanged: (DateFilter? newValue) {
              setState(() {
                _selectedDateFilter = newValue;
              });
            },
          ),
          // Display the filtered expenses here
          Expanded(
            child: ListView.builder(
              itemCount: _filterExpenses(_selectedDateFilter).length,
              itemBuilder: (context, index) {
                final expense = _filterExpenses(_selectedDateFilter)[index];
                return ListTile(
                  title: Text('\$${expense.expense.toStringAsFixed(2)}'),
                  subtitle: Text(expense.category.category.toString()),
                  trailing:
                      Text(DateFormat('yyyy-MM-dd').format(expense.timestamp)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
