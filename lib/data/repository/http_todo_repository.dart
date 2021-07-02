import 'package:todo_app/data/model/todo.dart';
import 'package:todo_app/data/repository/todo_repository.dart';
import 'package:todo_app/data/service/todo_http_client.dart';

class HttpTodoRepository implements TodoRepository {
  final TodoHttpClient client;

  HttpTodoRepository({required this.client});

  Future<List<Todo>> fetchTodos() async {
    final todosRaw = await client.fetchTodos();
    return todosRaw.map((json) => Todo.fromJson(json)).toList();
  }

  Future<bool> changeCompletion(int id, bool isCompleted) async {
    print("TodoRepository: changeCompletion");
    final patchObj = {"isCompleted": isCompleted.toString()};
    return await client.patchTodo(id, patchObj);
  }

  @override
  Future<Todo> addTodo(String message) {
    // TODO: implement addTodo
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteTodo(int id) {
    // TODO: implement deleteTodo
    throw UnimplementedError();
  }
}
