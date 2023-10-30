import 'package:flutter/material.dart';
import 'package:money_cards/view/screens/hive_adapter.dart';
import 'package:money_cards/view/screens/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HiveAdapter());
  // await Hive.openBox('contactDetails');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomeScreen()
    );
  }
}
