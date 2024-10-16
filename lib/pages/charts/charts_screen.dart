import 'package:flutter/material.dart';
import 'package:smart_expenses/pages/charts/widgets/bar_graph/weekly_chart.dart';

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Charts"),
      ),
      body: Column(
        children: [WeeklyChart()],
      ),
    );
  }
}
