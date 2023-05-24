import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/l10n/l10n.dart';
import 'package:notes/notes/notes.dart';
import 'package:notes/todo/todo.dart';

class AddTodoTile extends StatelessWidget {
  const AddTodoTile({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<NoteFormCubit, NoteFormState>(
      builder: (context, state) {
        return ListTile(
          title: Text(l10n.addTodo),
          leading: const Padding(
            padding: EdgeInsets.all(12),
            child: Icon(Icons.add),
          ),
          onTap: () {
            final todo = TodoItem.empty();
            final todos = state.note.todos;

            context.read<NoteFormCubit>().todosChanged([...todos, todo]);
          },
        );
      },
    );
  }
}
