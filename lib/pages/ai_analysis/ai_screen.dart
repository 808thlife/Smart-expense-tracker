import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_expenses/data/providers/expense_provider.dart';
import 'package:smart_expenses/network/ai_api.dart';

class AiScreen extends ConsumerStatefulWidget {
  const AiScreen({super.key});

  @override
  ConsumerState<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends ConsumerState<AiScreen> {
  Future<String> _fetchAnalysis() async {
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

    final response = await geminiService.generateAnalysis(
      expensesMap.toString(),
    );

    return response!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Analysis"),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: _fetchAnalysis(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('Error fetching analysis');
            } else if (snapshot.hasData) {
              return Markdown(data: snapshot.data!);
            } else {
              return const Text(
                'No data available',
              );
            }
          },
        ),
      ),
    );
  }
}
