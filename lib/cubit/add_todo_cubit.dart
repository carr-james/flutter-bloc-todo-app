import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/cubit/todos_cubit.dart';
import 'package:todo_app/data/repository/todo_repository.dart';

part 'add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  AddTodoCubit({required this.repository, required this.todosCubit})
      : super(AddTodoInitial());

  final TodoRepository repository;
  final TodosCubit todosCubit;

  void addTodo(String message) {
    if (message.isEmpty) {
      emit(AddTodoError(error: "todo message is empty"));
      return;
    }

    emit(AddingTodo());
    repository.addTodo(message).then((todo) {
      todosCubit.addTodo(todo);
      emit(TodoAdded());
    });
  }
}
