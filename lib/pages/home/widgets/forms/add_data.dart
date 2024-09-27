import 'package:flutter/material.dart';
import 'package:smart_expenses/data/models/categories_instances.dart';
import 'package:smart_expenses/data/models/expense.dart';

class AddDataForm extends StatefulWidget {
  const AddDataForm({super.key});

  @override
  State<AddDataForm> createState() => _AddDataFormState();
}

class _AddDataFormState extends State<AddDataForm> {
  final _formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final commentController = TextEditingController();

  ExpenseCategory? categoryController = categories[0];

  @override
  void dispose() {
    amountController.dispose();
    commentController.dispose();
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
                      value as double <= 0) {
                    return 'Please, check if the the amount is correct.';
                  }
                  return null;
                },
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
                      keyboardType: TextInputType
                          .text, // Adjust keyboard type if necessary
                    ),
                  ),
                  const SizedBox(
                      width: 20), // Add some spacing between the two widgets
                  Expanded(
                    child: SizedBox(
                      height:
                          58, // Match this to the height of the TextFormField
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
                    onPressed: () {},
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
