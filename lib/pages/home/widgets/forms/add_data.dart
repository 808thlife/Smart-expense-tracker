import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:smart_expenses/data/hive/expense_crud.dart';
import 'package:smart_expenses/data/models/categories_instances.dart';
import 'package:smart_expenses/data/models/expense.dart';
import 'package:smart_expenses/data/providers/expense_provider.dart';

class AddDataForm extends ConsumerStatefulWidget {
  const AddDataForm({super.key});

  @override
  ConsumerState<AddDataForm> createState() => _AddDataFormState();
}

class _AddDataFormState extends ConsumerState<AddDataForm> {
  final _formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final commentController = TextEditingController();
  final titleController = TextEditingController();

  DateTime? _selectedDate = DateTime.now();

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month - 1, now.day);
    final lastDate = DateTime(now.year, now.month + 1, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        firstDate: firstDate,
        lastDate: lastDate,
        initialDate: _selectedDate);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  ExpenseCategory? categoryController = categories[0];

  @override
  void dispose() {
    amountController.dispose();
    commentController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SizedBox(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              TextFormField(
                controller: amountController,
                decoration: InputDecoration(
                  label: Text(
                    "Amount of money spent",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      double.tryParse(value) == null ||
                      double.parse(value) <= 0) {
                    return 'Please, check if the the amount is correct.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  label: Text(
                    "Title",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please, check if the title is correct.';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: _presentDatePicker,
                    icon: const Icon(Icons.calendar_today),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    _selectedDate == null
                        ? 'No date selected'
                        : DateFormat.yMMMMEEEEd()
                            .format(_selectedDate!)
                            .toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: commentController,
                      decoration: InputDecoration(
                        label: Text(
                          "Commentary (optional)",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 58,
                      child: DropdownButtonFormField<ExpenseCategory>(
                        value: categoryController,
                        items: categories.map((category) {
                          return DropdownMenuItem<ExpenseCategory>(
                            value: category,
                            child: Row(
                              children: [
                                category.icon,
                                const SizedBox(width: 5),
                                Text(
                                  category.category.name,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (ExpenseCategory? value) {
                          setState(() {
                            categoryController = value;
                          });
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel"),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final expenseToAdd = Expense(
                          category: categoryController!.category,
                          comment: commentController.text,
                          expense: double.parse(
                            amountController.text,
                          ),
                          title: titleController.text,
                          timestamp: _selectedDate!,
                        );
                        final hiveManager = ExpenseManager();
                        hiveManager.addExpense(expenseToAdd);
                        ref.read(expenseProvider.notifier).addExpense(
                              expenseToAdd,
                            );
                        log(hiveManager.getExpenses().toString());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Color.fromARGB(184, 76, 175, 79),
                            content: Text(
                              "You have successfully added the expense!",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          Theme.of(context).colorScheme.inversePrimary),
                    ),
                    child: Text(
                      "Add",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
