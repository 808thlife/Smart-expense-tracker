import 'package:flutter/material.dart';
import 'package:smart_expenses/pages/charts/widgets/bar_graph/weekly_chart.dart';
import 'package:smart_expenses/pages/charts/widgets/pie_chart/pie_chart.dart';

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Charts"),
      ),
      body: Column(
        children: [
          Text(
            "Weekly Bar Chart",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 250,
            width: double.infinity,
            child: Card(
              child: WeeklyChart(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Weekly Pie Chart",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 250,
            width: double.infinity,
            child: Card(
              child: PieChartWidget(),
            ),
          )
        ],
      ),
    );
  }
}
