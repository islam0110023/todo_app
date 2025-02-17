import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/constants/app_colors.dart';
import 'package:todo_app/features/todos/presentation/widget/custom_update.dart';

import '../../logic/todo_app_cubit.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 5.r, horizontal: 11.r),
      padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.backgroundColorContainer,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              BlocProvider.of<TodoAppCubit>(context).checkTodo(index);
            },
            icon: Icon(
              BlocProvider.of<TodoAppCubit>(context).todos[index].isDone ==
                      false
                  ? Icons.circle_outlined
                  : Icons.check_circle_rounded,
              color: AppColors.floatingActionButtonColor,
            ),
          ),
          SizedBox(
            width: 13.w,
          ),
          Text(BlocProvider.of<TodoAppCubit>(context).todos[index].title,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              )),
          Spacer(),
          IconButton(
              onPressed: () {
                BlocProvider.of<TodoAppCubit>(context).removeTodo(index);
              },
              icon: Icon(
                Icons.delete_outline,
                color: AppColors.floatingActionButtonColor,
              )),
          IconButton(onPressed: () {
            showModalBottomSheet(context: context, builder: (context) {
              return CustomUpdate(index:index);
            },);
            
          }, icon: Icon(Icons.update,color: AppColors.floatingActionButtonColor,))
        ],
      ),
    );
  }
}
