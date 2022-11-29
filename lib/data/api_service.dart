import 'dart:convert';

import 'package:todo_list/models/task.dart';
import 'package:http/http.dart' as http;

import '../models/add_task.dart';

class ApiService {
  static const String _baseUrl = 'http://localhost:5000';

  Future<TaskResult> dataTask() async {
    final response = await http.get(Uri.parse(_baseUrl));

    print(response.statusCode);

    if (response.statusCode == 200) {
      return TaskResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<AddTaskResult> addTask({
    int? parentId,
    String? taskName,
    int? startDate,
    int? dueDate,
  }) async {
    var headers = {'Content-Type': 'application/json'};

    var body = jsonEncode(
      {
        'parentId': parentId,
        'taskName': taskName,
        'startDate': startDate,
        'dueDate': dueDate
      },
    );
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return AddTaskResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add new task');
    }
  }

  Future<AddTaskResult> editTask({
    int? id,
    String? taskName,
    bool? isDone,
    bool? starred,
    int? createdAt,
  }) async {
    var headers = {'Content-Type': 'application/json'};

    var body = jsonEncode(
      {
        'id': id,
        'taskName': taskName,
        'isDone': isDone,
        'starred': starred,
        'createdAt': createdAt
      },
    );
    final response = await http.put(
      Uri.parse(_baseUrl),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return AddTaskResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to edit task');
    }
  }

  Future<bool> doneTask({
    int? id,
    String? taskName,
    bool? isDone,
    bool? starred,
    int? createdAt,
  }) async {
    var headers = {'Content-Type': 'application/json'};

    var body = jsonEncode(
      {
        'id': id,
        'taskName': taskName,
        'isDone': isDone! ? false : true,
        'starred': starred,
        'createdAt': createdAt,
      },
    );
    final response = await http.put(
      Uri.parse('http://localhost:5000'),
      headers: headers,
      body: body,
    );

    return true;
  }

  Future<bool> deleteTask({int? id}) async {
    var headers = {'Content-Type': 'application/json'};

    final response = await http.delete(
      Uri.parse('http://localhost:5000/$id'),
      headers: headers,
    );

    return true;
  }
}
