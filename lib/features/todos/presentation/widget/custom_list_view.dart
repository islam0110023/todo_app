import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/constants/app_colors.dart';
import 'package:todo_app/features/todos/presentation/widget/custom_update.dart';

import '../../logic/add_note/add_todo_app_cubit.dart';
import '../../logic/get_notes/get_notes_cubit.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    var note = BlocProvider
        .of<GetNotesCubit>(context)
        .allNotes;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 5.r, horizontal: 11.r),
      padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.backgroundColorContainer,
      ),
      child: Column(
        children: [
          Row(
            children: [
              BlocBuilder<GetNotesCubit, GetNotesState>(
                builder: (context, state) {
                  var note = BlocProvider.of<GetNotesCubit>(context).allNotes[index];

                  return IconButton(
                    onPressed: () {
                      final cubit = BlocProvider.of<GetNotesCubit>(context);
                      cubit.allNotes[index].isDone = !cubit.allNotes[index].isDone;
                      cubit.allNotes[index].save();
                      cubit.emit(GetNotesSuccess()); 
                    },
                    icon: note.isDone
                        ? Icon(Icons.check_circle_rounded, color: AppColors.floatingActionButtonColor)
                        : Icon(Icons.circle_outlined, color: AppColors.floatingActionButtonColor),
                  );
                },
              ),

              SizedBox(
                width: 13.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note[index].title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      note[index].subTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor2,
                      ),
                    ),
                  ],
                ),
              ),

              IconButton(
                  onPressed: () {
                    //  BlocProvider.of<TodoAppCubit>(context).removeTodo(index);
                    note[index].delete();
                    BlocProvider.of<GetNotesCubit>(context).getAllNotes();
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    color: AppColors.floatingActionButtonColor,
                  )),
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,

                      transitionAnimationController: AnimationController(
                        vsync: Navigator.of(context),
                        duration: Duration(milliseconds: 999),
                        reverseDuration: Duration(milliseconds: 999),
                      ),
                      builder: (context) {
                        return CustomUpdate(index: index);
                      },
                    );
                  },
                  icon: Icon(
                    Icons.update,
                    color: AppColors.floatingActionButtonColor,
                  ))
            ],
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.r),
                child: Text(
                  note[index].date,
                  style:
                  TextStyle(color: Colors.grey.shade400, fontSize: 15.sp),
                ),
              ))
        ],
      ),
    );
  }
}
