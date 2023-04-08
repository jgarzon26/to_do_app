import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/task_tile.dart';
import '../providers/OverallTaskProvider.dart';

class CompletedList extends StatelessWidget {
  const CompletedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final taskProvider = context.watch<OverallTaskProvider>();
        if (index >= taskProvider.completedTaskCount) {
          return null;
        }
        return TaskTile(
          task: taskProvider.completedTasks[index],
        );
      },
    );
  }
}
