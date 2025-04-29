import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/core/constants/constant.dart';
import 'package:todo_app/features/todos/logic/add_note/add_todo_app_state.dart';
import 'package:todo_app/features/todos/model/todo_model.dart';

class AddTodoAppCubit extends Cubit<AddTodoAppState> {
  AddTodoAppCubit() : super(TodoAppInitial());

  addNotes(TodoModel note) async {
    emit(NotesLoading());
    try {
      var noteBox = Hive.box<TodoModel>(kNotesBox);
      await noteBox.add(note);
      emit(NotesLoaded());
    } catch (e) {
      emit(NotesFailure(
        error: e.toString(),
      ));
    }
  }
}
