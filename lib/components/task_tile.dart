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
  final bool isCompleted;

  TaskTile({
    super.key,
    required this.task,
    required this.isCompleted,
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

  void deleteTask(BuildContext context) {
    final provider = context.read<OverallTaskProvider>();
    if (isCompleted) {
      provider.removeCompletedTask(task);
    } else {
      provider.removeTask(task, false);
    }
    TaskSnackBar.buildSnackBar(
      context: context,
      textDisplay: "Task Deleted",
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: InkWell(
          onTap: !isCompleted ? () => goToEditTask(context) : () {},
          child: Slidable(
            closeOnScroll: false,
            key: Key(task.id),
            groupTag: const Uuid().v4(),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              extentRatio: 0.25,
              dismissible: isCompleted
                  ? DismissiblePane(
                      onDismissed: () {
                        context
                            .read<OverallTaskProvider>()
                            .removeCompletedTask(task);
                        TaskSnackBar.buildSnackBar(
                          context: context,
                          textDisplay: "Task Deleted",
                        );
                      },
                    )
                  : null,
              children: !isCompleted
                  ? [
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
                    ]
                  : [
                      SlidableAction(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        onPressed: (context) {
                          context
                              .read<OverallTaskProvider>()
                              .removeCompletedTask(task);
                          TaskSnackBar.buildSnackBar(
                            context: context,
                            textDisplay: "Task Deleted",
                          );
                        },
                        backgroundColor: kDeleteColor,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
            ),
            endActionPane: ActionPane(
              dismissible: DismissiblePane(
                onDismissed: () {
                  deleteTask(context);
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
                  onPressed: (context) {
                    deleteTask(context);
                  },
                  backgroundColor: kDeleteColor,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: ListTile(
              contentPadding: isCompleted
                  ? const EdgeInsets.all(8)
                  : const EdgeInsets.all(defaultPadding),
              leading: !isCompleted
                  ? StatefulBuilder(builder: (context, setState) {
                      return Checkbox(
                        value: _checkBox['isCheck'],
                        onChanged: (value) {
                          setState(() {
                            _checkBox['isCheck'] = value!;
                            context
                                .read<OverallTaskProvider>()
                                .removeTask(task, true);
                          });
                          TaskSnackBar.buildSnackBar(
                            context: context,
                            textDisplay: 'Task Completed',
                          );
                        },
                      );
                    })
                  : null,
              title: Text(
                task.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      decoration:
                          isCompleted ? TextDecoration.lineThrough : null,
                      letterSpacing: isCompleted ? 3 : null,
                    ),
              ),
              subtitle: !isCompleted
                  ? Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        task.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    )
                  : null,
              trailing: isCompleted
                  ? IconButton(
                      onPressed: () {
                        context
                            .read<OverallTaskProvider>()
                            .removeCompletedTask(task);
                        TaskSnackBar.buildSnackBar(
                          context: context,
                          textDisplay: "Task Deleted",
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: kDeleteColor,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}

/*
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
        margin: const EdgeInsets.symmetric(
          vertical: 15,
        ),
* */
