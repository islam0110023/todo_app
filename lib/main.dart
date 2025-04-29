import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/core/constants/constant.dart';
import 'package:todo_app/features/todos/logic/get_notes/get_notes_cubit.dart';
import 'package:todo_app/features/todos/model/todo_model.dart';
import 'package:todo_app/features/todos/presentation/todo_main_screen.dart';
import 'package:todo_app/simple_bloc_observer.dart';

void main() async {
  await Hive.initFlutter();
  Bloc.observer = SimpleBlocObserver();
  Hive.registerAdapter(TodoModelAdapter());
  await Hive.openBox<TodoModel>(kNotesBox);
  runApp(
    ScreenUtilInit(
      designSize: Size(431, 844),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => GetNotesCubit()..getAllNotes(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: TodoApp(),
          ),
        );
      },
      child: const TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      backgroundColor: Colors.white,
      duration: Duration(seconds: 3),
      onInit: () {
        debugPrint("On Init");
      },
      onEnd: () {
        debugPrint("On End");
      },
      childWidget: SizedBox(
        height: 200.h,
        width: 200.w,
        child: Image.asset("assets/app/pngegg.png"),
      ),
      onAnimationEnd: () => debugPrint("On Fade In End"),
      nextScreen: TodoMainScreen(),
    );
  }
}
