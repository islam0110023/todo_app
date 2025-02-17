import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todos/logic/todo_app_cubit.dart';

import 'custom_list_view.dart';

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Animate(
            effects: [FadeEffect(duration: Duration(seconds: 1))],
            child: CustomListView(index: index),
          );
        },
        itemCount: BlocProvider.of<TodoAppCubit>(context).todos.length,
      ),
    );
  }
}
