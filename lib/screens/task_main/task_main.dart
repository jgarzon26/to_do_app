import 'package:flutter/material.dart';
import 'package:to_do_app/screens/task_main/widgets/header.dart';

class TaskMain extends StatelessWidget {
  const TaskMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Header(
              numberOfTasks: 10,
              numberOfCompletedTasks: 10,
            ),
          ],
        ),
      ),
    );
  }
}
