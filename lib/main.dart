import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/features/todos/logic/todo_app_cubit.dart';
import 'package:todo_app/features/todos/logic/todo_app_state.dart';
import 'package:todo_app/features/todos/presentation/todo_main_screen.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: Size(431, 844),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => TodoAppCubit(),
          child: Builder(
              builder: (context) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: TodoApp(),
                );
              }
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
