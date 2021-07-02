import 'package:flutter/material.dart';
import 'package:todo_app/data/repository/inmemory_todo_repository.dart';
import 'package:todo_app/data/repository/todo_repository.dart';
import 'package:todo_app/presentation/screens/todos_screen.dart';

import 'presentation/router.dart';

void main() {
  TodoRepository todoRepository = InMemoryTodoRepository();

  runApp(TodoApp(
    router: AppRouter(todoRepository),
  ));
}

class TodoApp extends StatelessWidget {
  final AppRouter router;

  const TodoApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
    );
  }
}
