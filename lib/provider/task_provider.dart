import 'package:flutter/material.dart';
import 'package:todo_list/data/api_service.dart';
import 'package:todo_list/models/task.dart';

class TaskProvider with ChangeNotifier {
  late TaskResult _task;

  TaskResult get tasks => _task;

  set products(TaskResult tasks) {
    _task = tasks;
    notifyListeners();
  }

  Future<void> getTask() async {
    try {
      TaskResult task = await ApiService().dataTask();
      _task = task;
    } catch (e) {
      print(e);
    }
  }
}
