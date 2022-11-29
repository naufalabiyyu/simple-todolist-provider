import 'package:flutter/material.dart';

import '../data/api_service.dart';
import '../models/add_task.dart';

class ActionTaskProvider extends ChangeNotifier {
  AddTaskResult? _actionTask;
  String _message = '';

  String get message => _message;
  AddTaskResult? get actionTask => _actionTask;

  bool isBack = false;

  Future<bool> addNewTask({
    int? parentId,
    String? taskName,
    int? startDate,
    int? dueDate,
  }) async {
    try {
      AddTaskResult addTask = await ApiService().addTask(
        parentId: parentId,
        taskName: taskName,
        startDate: startDate,
        dueDate: dueDate,
      );
      _actionTask = addTask;
      notifyListeners();
      return true;
    } catch (e) {
      notifyListeners();
      _message = 'Data not match';
      print('Error --> $e');
      return false;
    }
  }

  Future<bool> editTask({
    int? id,
    String? taskName,
    bool? isDone,
    bool? starred,
    int? createdAt,
  }) async {
    try {
      AddTaskResult editTask = await ApiService().editTask(
        id: id,
        taskName: taskName,
        isDone: isDone,
        starred: starred,
        createdAt: createdAt,
      );
      _actionTask = editTask;
      notifyListeners();
      return true;
    } catch (e) {
      notifyListeners();
      _message = 'Data not match';
      print('Error --> $e');
      return false;
    }
  }
}
