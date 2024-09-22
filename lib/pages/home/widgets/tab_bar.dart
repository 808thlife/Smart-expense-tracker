import 'package:flutter/material.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({super.key});

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: [
        Tab(
          icon: Icon(Icons.attach_money),
          child: Text("Expenses"),
        ),
        Tab(
          icon: Icon(Icons.auto_graph),
          child: Text("Income"),
        ),
      ],
    );
  }
}
