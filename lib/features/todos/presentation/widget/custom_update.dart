import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/constants/app_colors.dart';
import 'package:todo_app/features/todos/logic/get_notes/get_notes_cubit.dart';
import 'package:todo_app/features/todos/model/todo_model.dart';

import 'custom_text_field.dart';

class CustomUpdate extends StatelessWidget {
  CustomUpdate({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    var note = BlocProvider.of<GetNotesCubit>(context).allNotes[index];

    return Container(
      height: 420.h,
      padding: EdgeInsets.all(20.r),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(28.r),
          topLeft: Radius.circular(28.r),
        ),
      ),
      child: CustomForm(
        note: note,
      ),
    );
  }
}

class CustomForm extends StatefulWidget {
  const CustomForm({
    super.key,
    required this.note,
  });
  final TodoModel note;

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  late TextEditingController controller;
  late TextEditingController controller1;
  final FocusNode focusNode = FocusNode();
  final FocusNode focusNode1 = FocusNode();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.note.title);
    controller1 = TextEditingController(text: widget.note.subTitle); // إذا عندك content
  }
  @override
  void dispose() {
    // TODO: implement dispose
    focusNode.dispose();
    focusNode1.dispose();
    controller.dispose();
    controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40.h,
        ),
        CustomTextField(
          focusNode: focusNode,
          controller: controller,
          name: 'Task Title',
        ),
        SizedBox(
          height: 20.h,
        ),
        CustomTextField(
          focusNode: focusNode1,
          controller: controller1,
          name: 'Content',
          maxLines: 5,
        ),
        SizedBox(
          height: 50.h,
        ),
        MaterialButton(
          onPressed: () {
            widget.note.title = controller.text ;
            widget.note.subTitle = controller1.text ;
            widget.note.save();
            BlocProvider.of<GetNotesCubit>(context).getAllNotes();
            Navigator.pop(context);

          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          padding: EdgeInsets.all(15.r),
          minWidth: double.maxFinite,
          color: AppColors.floatingActionButtonColor,
          child: Text("Save"),
        )
      ],
    );
  }
}
