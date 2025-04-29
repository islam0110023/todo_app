import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/core/constants/constant.dart';
import 'package:todo_app/features/todos/model/todo_model.dart';

part 'get_notes_state.dart';

class GetNotesCubit extends Cubit<GetNotesState> {
  GetNotesCubit() : super(GetNotesInitial());
  List<TodoModel> allNotes = [];
  getAllNotes() {

      var noteBox = Hive.box<TodoModel>(kNotesBox);

      allNotes = noteBox.values.toList();
      emit(GetNotesSuccess());

  }
}
