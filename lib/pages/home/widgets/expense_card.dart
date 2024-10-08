import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_expenses/data/models/expense.dart';
import 'package:smart_expenses/data/providers/expense_provider.dart';

class ExpenseCard extends ConsumerWidget {
  const ExpenseCard({super.key, required this.expense});

  final Expense expense;

  void removeExpense(String expenseID, WidgetRef ref) {
    ref.read(expenseProvider.notifier).removeExpense(expenseID);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseNotifier = ref.read(expenseProvider.notifier);
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
            removeExpense(expense.id!, ref);
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
            child: SizedBox(
              height: 100,
              child: Card(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                expense.category.category.name.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                "${expense.expense.toString()} \$",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          color: expense.category.color,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20)),
                      height: 250,
                      width: 100,
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
