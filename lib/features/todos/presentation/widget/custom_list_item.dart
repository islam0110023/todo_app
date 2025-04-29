import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todos/logic/get_notes/get_notes_cubit.dart';

import 'custom_list_view.dart';

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetNotesCubit, GetNotesState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<GetNotesCubit>(context);
        return Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Animate(
                effects: [FadeEffect(duration: Duration(seconds: 2))],
                child: CustomListView(index: index),
              );
            },
            itemCount: cubit.allNotes.length,
          ),
        );
      },
    );
  }
}
