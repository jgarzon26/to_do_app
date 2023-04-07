import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/components/task_snackbar.dart';
import 'package:to_do_app/constants.dart';
import 'package:to_do_app/providers/OverallTaskProvider.dart';

import '../../classes/Task.dart';

class EditTask extends StatefulWidget {
  const EditTask({
    Key? key,
    required this.task,
    required this.context,
  }) : super(key: key);

  final Task task;
  final BuildContext context;

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController =
        TextEditingController(text: widget.task.description);
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 4,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: defaultIconSize,
          ),
        ),
        title: const Text(
          'Edit Task',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              widget.context
                  .read<OverallTaskProvider>()
                  .removeTask(widget.task, false);
              TaskSnackBar.buildSnackBar(
                  context: context, textDisplay: "Task Deleted");
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.delete,
              size: defaultIconSize,
            ),
          ),
        ],
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.8,
          margin: const EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(40),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.9,
                child: ElevatedButton(
                  onPressed: () {
                    widget.context.read<OverallTaskProvider>().editTask(
                          widget.task,
                          _titleController.text,
                          _descriptionController.text,
                        );
                    TaskSnackBar.buildSnackBar(
                        context: context, textDisplay: "Task Edited");
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'SAVE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 4,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
