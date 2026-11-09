import 'package:flutter/material.dart';
import 'package:task_manager/database/database.dart';
import 'package:task_manager/pages/home/home_page.dart';

final db = AppDatabase();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: HomePage(),
    );
  }
}
