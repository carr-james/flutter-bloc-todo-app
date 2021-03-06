import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/data/model/todo.dart';
import 'package:todo_app/data/repository/todo_repository.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  final TodoRepository repository;

  TodosCubit({required this.repository}) : super(TodosInitial());

  void fetchTodos() {
    Timer(Duration(seconds: 3), () {
      repository.fetchTodos().then((todos) {
        emit(TodosLoaded(todos: todos));
      });
    });
  }

  void changeCompletion(Todo todo) {
    print("todoCubit: changeCompletion");
    repository.changeCompletion(todo.id, !todo.isCompleted).then((isChanged) {
      if (isChanged) {
        todo.isCompleted = !todo.isCompleted;
        _updateTodoList();
      }
    });
  }

  void _updateTodoList() {
    final currentState = state;
    if (currentState is TodosLoaded) {
      emit(TodosLoaded(todos: currentState.todos));
    }
  }

  void addTodo(Todo todo) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final todosList = currentState.todos;
      todosList.add(todo);
      emit(TodosLoaded(todos: todosList));
    }
  }

  void deleteTodo(Todo todo) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final todosList =
          currentState.todos.where((element) => element.id != todo.id).toList();
      emit(TodosLoaded(todos: todosList));
    }
  }
}
