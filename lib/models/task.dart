class TaskResult {
  TaskResult({
    required this.message,
    required this.data,
  });

  String message;
  List<Task> data;

  factory TaskResult.fromJson(Map<String, dynamic> json) => TaskResult(
        message: json["message"],
        data: List<Task>.from(json["data"].map((x) => Task.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Task {
  Task({
    this.id,
    this.parentId,
    this.taskName,
    this.isDone,
    this.startDate,
    this.dueDate,
    this.starred,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? parentId;
  String? taskName;
  bool? isDone;
  dynamic? startDate;
  dynamic? dueDate;
  bool? starred;
  int? createdAt;
  dynamic? updatedAt;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        parentId: json["parentId"],
        taskName: json["taskName"],
        isDone: json["isDone"],
        startDate: json["startDate"],
        dueDate: json["dueDate"],
        starred: json["starred"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parentId": parentId,
        "taskName": taskName,
        "isDone": isDone,
        "startDate": startDate,
        "dueDate": dueDate,
        "starred": starred,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
