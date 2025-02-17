

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todos/logic/todo_app_state.dart';
import 'package:todo_app/features/todos/model/todo_model.dart';


class TodoAppCubit extends Cubit<TodoAppState> {
  TodoAppCubit() : super(TodoAppInitial());
  List<TodoModel>todos = [];
  void addTodo(String todo) {
    todos.add(TodoModel(title: todo));
    emit(TodoAppAdd());
  }
  void checkTodo(int index){
    todos[index].isDone=!todos[index].isDone;
    emit(TodoAppAdd());

  }
  void removeTodo(int index){
    todos.removeAt(index);
    emit(TodoAppAdd());
  }
  void updateTodo(int index,String todo){
    todos[index].title=todo;
    emit(TodoAppAdd());


  }
}
