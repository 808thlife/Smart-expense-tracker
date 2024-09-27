import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_expenses/pages/home/widgets/forms/add_data.dart';
import 'package:smart_expenses/pages/home/widgets/tab_bar.dart';

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
              title: const Text('Graphs'),
              leading: const Icon(CupertinoIcons.graph_square),
              onTap: () {},
            ),
            ListTile(
              title: const Text('AI analysis'),
              leading: const Icon(CupertinoIcons.bubble_right),
              onTap: () {},
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
              TabBarWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
