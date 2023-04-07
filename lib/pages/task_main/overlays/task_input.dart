import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/components/task_snackbar.dart';
import 'package:to_do_app/constants.dart';

import '../../../classes/Task.dart';
import '../../../providers/OverallTaskProvider.dart';

class TaskInput extends PopupRoute {
  late final TextEditingController _taskNameController;
  late final TextEditingController _taskDescriptionController;

  final BuildContext _context;

  TaskInput(this._context);

  @override
  Color? get barrierColor => Colors.black.withAlpha(0x90);

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => "Task Input";

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  void install() {
    _taskNameController = TextEditingController();
    _taskDescriptionController = TextEditingController();
    super.install();
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _taskDescriptionController.dispose();
    super.dispose();
  }

  static const _defaultPadding =
      EdgeInsets.symmetric(horizontal: 20, vertical: 10);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Center(
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        elevation: 4.0,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 5),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                width: double.infinity,
                height: 60,
                child: Padding(
                  padding: _defaultPadding,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'New Task',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: _defaultPadding,
                child: TextField(
                  autofocus: true,
                  controller: _taskNameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: _defaultPadding,
                  child: TextField(
                    controller: _taskDescriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                    maxLines: 10,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.8,
                child: ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style,
                  onPressed: () {
                    _context.read<OverallTaskProvider>().addTask(
                          Task(
                            title: _taskNameController.text,
                            description: _taskDescriptionController.text,
                          ),
                        );
                    TaskSnackBar.buildSnackBar(
                      context: context,
                      textDisplay: "Task Added",
                    );
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Add'.toUpperCase(),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                          letterSpacing: 3,
                        ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
