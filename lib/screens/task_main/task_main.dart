import 'package:flutter/material.dart';

class TaskMain extends StatelessWidget {
  const TaskMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo App'),
      ),
    );
  }
}
