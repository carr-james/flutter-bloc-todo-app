import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/edit_todo_cubit.dart';
import 'package:todo_app/data/model/todo.dart';

class EditTodoScreen extends StatelessWidget {
  EditTodoScreen({Key? key, required this.todo}) : super(key: key);

  final Todo todo;
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = todo.message;

    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Todo"),
          actions: [
            InkWell(
              onTap: () {
                BlocProvider.of<EditTodoCubit>(context).deleteTodo(todo);
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.delete),
              ),
            )
          ],
        ),
        body: BlocListener<EditTodoCubit, EditTodoState>(
          listener: (context, state) {
            if(state is TodoEdited){
              Navigator.pop(context);
            }
          },
          child: _body(context),
        ));
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            autofocus: true,
            controller: _controller,
            decoration: InputDecoration(hintText: "Enter todo message..."),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(onTap: () {}, child: _updateButton(context))
        ],
      ),
    );
  }

  Widget _updateButton(context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 50.0,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(10.0)),
      child: Center(
          child: Text(
            "Update Todo",
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
