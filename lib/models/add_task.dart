import 'task.dart';

class AddTaskResult {
  AddTaskResult({
    required this.message,
    required this.data,
  });

  String message;
  Task data;

  factory AddTaskResult.fromJson(Map<String, dynamic> json) => AddTaskResult(
        message: json["message"],
        data: Task.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}
