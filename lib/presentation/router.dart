import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/constants/routes.dart';
import 'package:todo_app/cubit/todos_cubit.dart';
import 'package:todo_app/cubit/add_todo_cubit.dart';
import 'package:todo_app/cubit/edit_todo_cubit.dart';
import 'package:todo_app/data/model/todo.dart';
import 'package:todo_app/data/repository/todo_repository.dart';
import 'package:todo_app/presentation/screens/add_todo_screen.dart';
import 'package:todo_app/presentation/screens/edit_todo_screen.dart';
import 'package:todo_app/presentation/screens/todos_screen.dart';

class AppRouter {
  TodoRepository todoRepository;
  TodosCubit todosCubit;

  AppRouter(this.todoRepository)
      : todosCubit = TodosCubit(repository: todoRepository);

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: todosCubit,
                  child: TodosScreen(),
                ));
      case EDIT_TODO_ROUTE:
        final Todo todo = settings.arguments as Todo;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => EditTodoCubit(
                    repository: todoRepository,
                    todosCubit: todosCubit,
                  ),
                  child: EditTodoScreen(todo: todo),
                ));
      case ADD_TODO_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AddTodoCubit(
                    repository: todoRepository,
                    todosCubit: todosCubit,
                  ),
                  child: AddTodoScreen(),
                ));
      default:
        throw Exception();
    }
  }
}
