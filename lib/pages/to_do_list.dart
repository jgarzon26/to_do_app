import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/task_tile.dart';
import '../providers/OverallTaskProvider.dart';

class ToDoList extends StatelessWidget {
  const ToDoList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final taskProvider = context.watch<OverallTaskProvider>();
        if (index >= taskProvider.taskCount) {
          return null;
        }
        return TaskTile(
          task: taskProvider.tasks[index],
        );
      },
    );
  }
}
