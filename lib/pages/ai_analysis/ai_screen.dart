import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_expenses/data/providers/expense_provider.dart';
import 'package:smart_expenses/network/ai_api.dart';

class AiScreen extends ConsumerStatefulWidget {
  const AiScreen({super.key});

  @override
  ConsumerState<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends ConsumerState<AiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Analysis"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                // Correct use of ref.read
                GeminiService geminiService = GeminiService();

                List<Map<String, dynamic>> expensesMap = ref
                    .read(expenseProvider)
                    .map((expense) => {
                          "timestmap": expense.timestamp.toString(),
                          "amount": expense.expense.toString(),
                          "comment": expense.comment.toString(),
                          "category": expense.category.category.name,
                        })
                    .toList();

                print(expensesMap);
                final response = await geminiService.generateAnalysis(
                  expensesMap.toString(),
                );
                print(response);
              },
              child: const Text("Request analysis"),
            ),
          ],
        ),
      ),
    );
  }
}
