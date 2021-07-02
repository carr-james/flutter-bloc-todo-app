import 'package:todo_app/data/model/todo.dart';
import 'package:todo_app/data/repository/todo_repository.dart';

class InMemoryTodoRepository implements TodoRepository {
  int nextSequenceId = 6;
  final Map<int, Todo> todos = {
    1: Todo(id: 1, isCompleted: false, message: "1"),
    2: Todo(id: 2, isCompleted: true, message: "2"),
    3: Todo(id: 3, isCompleted: false, message: "3"),
    4: Todo(id: 4, isCompleted: true, message: "4"),
    5: Todo(id: 5, isCompleted: false, message: "5"),
  };

  @override
  Future<List<Todo>> fetchTodos() {
    return Future.delayed(Duration(seconds: 1), () => todos.values.toList());
  }

  @override
  Future<bool> changeCompletion(int id, bool isCompleted) {
    if (!todos.containsKey(id)) {
      print('ERROR: Todo(id = $id) does exist');
      return Future.delayed(Duration(seconds: 1), () => false);
    }
    Todo todo = todos[id]!;
    if (todo.isCompleted == isCompleted) {
      print(
          'ERROR: Attempting to set isCompleted to "$isCompleted", but is already "$isCompleted"');
      return Future.delayed(Duration(seconds: 1), () => false);
    }

    todos[id] = todo.withIsCompleted(isCompleted);
    print(todos);
    return Future.delayed(Duration(seconds: 1), () => true);
  }

  @override
  Future<Todo> addTodo(String message) {
    final id = nextSequenceId;
    nextSequenceId++;

    final Todo todo = Todo(id: id, message: message, isCompleted: false);
    todos[id] = todo;

    return Future.delayed(Duration(seconds: 1), () => todo);
  }

  @override
  Future<bool> deleteTodo(int id) {
    todos.remove(id);

    return Future.delayed(Duration(seconds: 1), () => true);
  }
}
