import 'package:flutter/material.dart';
import 'package:to_do_app/screens/task_main/task_main.dart';

main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      routes: {
        '/': (context) => const TaskMain(),
      },
    );
  }
}
