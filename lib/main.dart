import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:to_do_app/providers/OverallTaskProvider.dart';
import 'components/task_main/task_main.dart';
import 'default_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

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
