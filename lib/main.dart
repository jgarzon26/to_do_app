import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/pages/task_main/task_main.dart';
import 'package:to_do_app/providers/OverallTaskProvider.dart';

import 'default_theme.dart';

main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OverallTaskProvider(),
      child: MaterialApp(
        title: 'ToDo App',
        theme: DefaultTheme.buildThemeData(),
        routes: {
          '/': (context) => const TaskMain(),
        },
      ),
    );
  }
}
