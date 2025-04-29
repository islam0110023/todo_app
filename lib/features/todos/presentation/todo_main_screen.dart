import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/constants/app_colors.dart';
import 'package:todo_app/features/todos/logic/add_note/add_todo_app_cubit.dart';
import 'package:todo_app/features/todos/logic/get_notes/get_notes_cubit.dart';
import 'package:todo_app/features/todos/presentation/widget/custom_bottom_shett.dart';
import 'package:todo_app/features/todos/presentation/widget/custom_list_item.dart';

class TodoMainScreen extends StatelessWidget {
  const TodoMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: AppColors.primaryColor,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: AppColors.primaryColor,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_none_rounded,
                color: AppColors.primaryColor,
              )),
        ],
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, Islam",
                style:
                TextStyle(fontSize: 40.sp, color: AppColors.primaryColor),
              ),
              SizedBox(
                height: 54.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today's Tasks",
                    style:
                    TextStyle(fontSize: 16.sp, color: AppColors.textColor),
                  ),
                  BlocBuilder<GetNotesCubit, GetNotesState>(
                    builder: (context, state) {
                      var notes=BlocProvider.of<GetNotesCubit>(context).allNotes;
                      return Text(
                        "${notes.length} tasks",
                        style:
                        TextStyle(fontSize: 16.sp, color: AppColors.textColor),
                      );
                    },
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomListItem()
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            backgroundColor: Colors.transparent,
            transitionAnimationController: AnimationController(
              vsync: Navigator.of(context),
              duration: Duration(milliseconds: 999),
              reverseDuration: Duration(milliseconds: 999),
            ),
            builder: (context) {
              return CustomBottomShett();
            },
          );
        },
        backgroundColor: AppColors.floatingActionButtonColor,
        child: Icon(
          Icons.add,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
