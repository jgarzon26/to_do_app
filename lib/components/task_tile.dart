import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/components/task_snackbar.dart';
import 'package:to_do_app/constants.dart';
import 'package:to_do_app/providers/OverallTaskProvider.dart';
import 'package:uuid/uuid.dart';

import '../classes/Task.dart';
import '../screens/edit_task/edit_task.dart';

class TaskTile extends StatelessWidget {
  final _checkBox = {
    'isCheck': false,
  };

  final Task task;

  TaskTile({
    super.key,
    required this.task,
  });

  void goToEditTask(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditTask(
          context: context,
          task: task,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => goToEditTask(context),
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Slidable(
          key: Key(task.id),
          groupTag: const Uuid().v4(),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.25,
            children: [
              SlidableAction(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                onPressed: (context) {
                  goToEditTask(context);
                },
                backgroundColor: kCheckColor,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edit',
              ),
            ],
          ),
          endActionPane: ActionPane(
            dismissible: DismissiblePane(
              onDismissed: () {
                context.read<OverallTaskProvider>().removeTask(task, false);
                TaskSnackBar.buildSnackBar(
                    context: context, textDisplay: "Task Deleted");
              },
            ),
            motion: const ScrollMotion(),
            extentRatio: 0.25,
            children: [
              SlidableAction(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                onPressed: (context) {},
                backgroundColor: kDeleteColor,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StatefulBuilder(builder: (context, setState) {
                  return Checkbox(
                    value: _checkBox['isCheck'],
                    onChanged: (value) {
                      setState(() {
                        _checkBox['isCheck'] = value!;
                      });
                    },
                  );
                }),
              ],
            ),
            title: Text(
              task.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                task.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
