import 'dart:collection';

import 'package:flutter/material.dart';

import '../classes/Task.dart';

class OverallTaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [], _completedTasks = [];
  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);
  UnmodifiableListView<Task> get completedTasks =>
      UnmodifiableListView(_completedTasks);

  int get taskCount => _tasks.length;
  int get completedTaskCount => _completedTasks.length;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void removeTask(Task task, bool isCompleted) {
    if (isCompleted) {
      _completedTasks.add(task);
    }
    _tasks.remove(task);
    notifyListeners();
  }

  void removeCompletedTask(Task task) {
    _completedTasks.remove(task);
    notifyListeners();
  }
}
