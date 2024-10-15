import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_expenses/data/hive/expense_crud.dart';
import 'package:smart_expenses/data/models/categories_instances.dart';
import 'package:smart_expenses/data/models/expense.dart';
import 'package:smart_expenses/data/providers/expense_provider.dart';

class ExpenseCard extends ConsumerWidget {
  const ExpenseCard({super.key, required this.expense});

  final Expense expense;

  void removeExpense(String expenseID, WidgetRef ref) {
    final expenseManager = ExpenseManager();

    expenseManager.removeExpense(expense);
    log("Removed from hive.");
    log(expenseManager.getExpenses().toString());
    ref.read(expenseProvider.notifier).removeExpense(expenseID);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseNotifier = ref.read(expenseProvider.notifier);
    //Hive

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Dismissible(
          key: Key(expense.id!),
          background: Container(
            color: Theme.of(context).colorScheme.error,
          ),
          onDismissed: (direction) {
            removeExpense(expense.id, ref);
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    const Text("Removed an expense from your expenses list"),
                backgroundColor: Theme.of(context).colorScheme.error,
                action: SnackBarAction(
                  label: "Undo",
                  textColor: Colors.black,
                  onPressed: () {
                    // Restore the expense using the notifier, which still exists
                    expenseNotifier.addExpense(expense);
                  },
                ),
              ),
            );
          },
          child: GestureDetector(
            onTap: () {
              Widget buildDetailRow(String label, String value) {
                return Row(
                  children: [
                    Text(
                      "$label: ",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold), // Bold label
                    ),
                    Expanded(
                      child: Text(value),
                    ),
                  ],
                );
              }

              showDialog(
                context: context,
                builder: (context) {
                  final String comment = expense.comment ?? "";
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20), // Rounded corners for the dialog
                    ),
                    title: const Text(
                      "Expense Details",
                    ), // Add a title to the dialog
                    content: SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisSize:
                            MainAxisSize.min, // Adjust height based on content
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Align text to the start
                        children: [
                          buildDetailRow(
                            "Title",
                            expense.title,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          buildDetailRow(
                            "Amount",
                            expense.expense.toString(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          buildDetailRow("Category", expense.category.name),
                          const SizedBox(height: 10),
                          buildDetailRow("Timestamp", expense.getDate),
                          const SizedBox(height: 10),
                          expense.comment != ""
                              ? buildDetailRow("Comment", comment)
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Close"),
                      ),
                    ],
                  );
                },
              );
            },
            child: SizedBox(
              height: 100,
              child: Card(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: getCategoryDetails(expense.category).color,
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 250,
                      width: 100,
                      child: getCategoryDetails(expense.category).icon,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                expense.title.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Flexible(
                              child: Text(
                                "${expense.expense.toString()} \$",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(expense.getDate),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
