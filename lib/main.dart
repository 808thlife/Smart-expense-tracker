import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_expenses/config/theme/theme.dart';
import 'package:smart_expenses/config/theme/util.dart';
import 'package:smart_expenses/data/models/expense.dart';
import 'package:smart_expenses/pages/home/homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();

  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(ExpenseCategoryEnumAdapter());

  await Hive.openBox<Expense>('expense');

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme =
        createTextTheme(context, "Montserrat Alternates", "Montserrat");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Expense',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: const Homepage(),
    );
  }
}
