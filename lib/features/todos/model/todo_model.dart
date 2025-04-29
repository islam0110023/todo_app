import 'package:hive/hive.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel extends HiveObject {
  @HiveField(0)
   String title;
  @HiveField(1)
   String subTitle;
  @HiveField(2)
  final int color;
  @HiveField(3)
  final String date;
  @HiveField(4)
  bool isDone;
  TodoModel(
      {required this.subTitle,
      required this.color,
      required this.date,
      required this.title,
      this.isDone = false});
}
