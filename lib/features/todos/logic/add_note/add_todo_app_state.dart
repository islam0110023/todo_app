
abstract class AddTodoAppState {}

final class TodoAppInitial extends AddTodoAppState {}

final class TodoAppAdd extends AddTodoAppState {}
final class NotesLoading extends AddTodoAppState {}
final class NotesLoaded extends AddTodoAppState {}
final class NotesFailure extends AddTodoAppState {
  final String error;
  NotesFailure({required this.error });
}
