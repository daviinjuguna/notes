import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/notes/notes.dart';
import 'package:notes/utils/utils.dart';

class NoteColor extends StatelessWidget {
  const NoteColor({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteFormCubit, NoteFormState>(
      builder: (context, state) {
        return SizedBox(
          height: 80,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: AppColor.noteColors.length,
            separatorBuilder: (context, index) {
              return const SizedBox(width: 12);
            },
            itemBuilder: (BuildContext context, int index) {
              final color = AppColor.noteColors[index];

              return GestureDetector(
                onTap: () {
                  context.read<NoteFormCubit>().colorChanged(color);
                },
                child: Material(
                  color: color,
                  elevation: 5,
                  shape: CircleBorder(
                    side: state.note.color.isValid &&
                            state.note.color.value == color
                        ? const BorderSide(width: 1.5)
                        : BorderSide.none,
                  ),
                  child: const SizedBox(
                    width: 50,
                    height: 50,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
