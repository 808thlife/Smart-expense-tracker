import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_expenses/pages/ai_analysis/ai_screen.dart';
import 'package:smart_expenses/pages/charts/charts_screen.dart';
import 'package:smart_expenses/pages/home/widgets/expenses_list.dart';
import 'package:smart_expenses/pages/home/widgets/forms/add_data.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Smart Expenses",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/drawer_header.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: SizedBox(),
            ),
            ListTile(
              title: const Text('Charts'),
              leading: const Icon(CupertinoIcons.graph_square),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ChartsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('AI analysis'),
              leading: const Icon(CupertinoIcons.bubble_right),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AiScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return const AddDataForm();
            },
          );
        },
        child: const Icon(
          CupertinoIcons.add_circled,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 0,
        ),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              // TabBarWidget(),

              //TODO: Make it work (later).
              // DateCategories(),
              SizedBox(
                height: 35,
              ),
              Expanded(
                child: ExpensesList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
