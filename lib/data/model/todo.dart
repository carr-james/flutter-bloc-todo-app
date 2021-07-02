import 'package:flutter/cupertino.dart';

class Todo {
  int id;
  String message;
  bool isCompleted;

  Todo(
      {required this.id, required this.message, required this.isCompleted});

  Todo.fromJson(Map json)
      : message = json["todo"],
        isCompleted = json["isCompleted"] == "true",
        id = json["id"] as int;

  Todo withIsCompleted(bool isCompleted) =>
      new Todo(id: id, message: message, isCompleted: isCompleted);

  @override
  String toString() {
    return 'Todo{id: $id, message: $message, isCompleted: $isCompleted}';
  }
}
