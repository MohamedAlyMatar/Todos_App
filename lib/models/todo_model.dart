// To parse this JSON data, do
//
//     final todoModel = todoModelFromJson(jsonString);

import 'dart:convert';
import 'dart:math';

TodoModel todoModelFromJson(String str) => TodoModel.fromJson(json.decode(str));

String todoModelToJson(TodoModel data) => json.encode(data.toJson());

class TodoModel {
  int id;
  String todo;
  bool completed;
  int userId;

  TodoModel({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json["id"],
        todo: json["todo"],
        completed: json["completed"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "todo": todo,
        "completed": completed,
        "userId": userId,
      };
}

TodoModel createTodoModel(String todoText) {
  // Generate random IDs for demonstration purposes
  final random = Random();
  int id = random.nextInt(1000); // Random ID between 0 and 999
  int userId = random.nextInt(100); // Random user ID between 0 and 99

  return TodoModel(
    id: id,
    todo: todoText,
    completed: false,
    userId: userId,
  );
}
