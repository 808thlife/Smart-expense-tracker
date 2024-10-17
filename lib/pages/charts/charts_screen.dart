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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 350,
              width: double.infinity,
              child: Card(
                child: Column(
                  children: [
                    Text(
                      "Weekly Bar Chart",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const WeeklyChart(),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                height: 500,
                width: double.infinity,
                child: Card(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Weekly Pie Chart",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const PieChartWidget()
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
