import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/constants/app_colors.dart';
import 'package:todo_app/features/todos/logic/todo_app_cubit.dart';

class CustomUpdate extends StatelessWidget {
  CustomUpdate({super.key, required this.index});
  final int index;
  final TextEditingController controller= TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.text=BlocProvider.of<TodoAppCubit>(context).todos[index].title;
    return Container(
      height: 500.h,
      padding: EdgeInsets.all(20.r),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(28.r),
          topLeft: Radius.circular(28.r),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 80.h,
          ),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              hintText: "Task Title",
              hintStyle: TextStyle(
                color: AppColors.primaryColor,
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              String todo=controller.text;
              BlocProvider.of<TodoAppCubit>(context).updateTodo(index,todo);
              Navigator.of(context).pop();
            },
            color: AppColors.floatingActionButtonColor,
            child: Text("Save"),
          )
        ],
      ),
    );
  }
}
