import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:todo_app/core/constants/app_colors.dart';
import 'package:todo_app/features/todos/logic/add_note/add_todo_app_cubit.dart';
import 'package:todo_app/features/todos/logic/add_note/add_todo_app_state.dart';
import 'package:todo_app/features/todos/logic/get_notes/get_notes_cubit.dart';
import 'package:todo_app/features/todos/model/todo_model.dart';
import 'package:todo_app/features/todos/presentation/widget/custom_text_field.dart';

class CustomBottomShett extends StatelessWidget {
  const CustomBottomShett({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTodoAppCubit(),
      child: Container(
        height: 420.h,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        padding: EdgeInsets.all(20.r),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(28.r),
            topLeft: Radius.circular(28.r),
          ),
        ),
        child: BlocConsumer<AddTodoAppCubit, AddTodoAppState>(
          listener: (context, state) {
            if (state is NotesLoaded) {
              BlocProvider.of<GetNotesCubit>(context).getAllNotes();
              Navigator.of(context).pop();
            }
            if (state is NotesFailure) {
              print(state.error);
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
                inAsyncCall: state is NotesLoading ? true : false,
                child: CustomForm());
          },
        ),
      ),
    );
  }
}

class CustomForm extends StatefulWidget {
  const CustomForm({
    super.key,
  });

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController controller1 = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  final FocusNode focusNode = FocusNode();
  final FocusNode focusNode1 = FocusNode();
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
    return Form(
      key: formKey,
      autovalidateMode: autoValidateMode,
      child: Column(
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
          BlocBuilder<AddTodoAppCubit, AddTodoAppState>(
            builder: (context, state) {
              return MaterialButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    var currentDate=DateTime.now();
                    var formattedDate=DateFormat.yMEd().format(currentDate);

                    TodoModel note = TodoModel(
                        subTitle: controller1.text,
                        color: 0,
                        date: formattedDate,
                        title: controller.text);
                    BlocProvider.of<AddTodoAppCubit>(context).addNotes(note);
                  } else {
                    autoValidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r)),
                padding: EdgeInsets.all(15.r),
                minWidth: double.maxFinite,
                color: AppColors.floatingActionButtonColor,
                child: state is NotesLoading
                    ? SizedBox(
                        width: 24.r,
                        height: 24.r,
                        child: CircularProgressIndicator())
                    : Text("Save"),
              );
            },
          )
        ],
      ),
    );
  }
}
