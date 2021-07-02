import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/cubit/todos_cubit.dart';
import 'package:todo_app/data/model/todo.dart';
import 'package:todo_app/data/repository/todo_repository.dart';

part 'edit_todo_state.dart';

class EditTodoCubit extends Cubit<EditTodoState> {
  EditTodoCubit({required this.repository, required this.todosCubit})
      : super(EditTodoInitial());
  final TodoRepository repository;
  final TodosCubit todosCubit;

  void deleteTodo(Todo todo) {
    repository.deleteTodo(todo.id)
    .then((isDeleted) {
      todosCubit.deleteTodo(todo);
      emit(TodoEdited());
    });

  }
}
