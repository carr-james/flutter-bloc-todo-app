import 'package:todo_app/data/model/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> fetchTodos();
  Future<bool> changeCompletion(int id, bool isCompleted);
  Future<Todo> addTodo(String message);
  Future<bool> deleteTodo(int id);
}