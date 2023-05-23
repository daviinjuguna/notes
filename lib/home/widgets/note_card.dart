import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:notes/notes/notes.dart';
import 'package:notes/routes/app_router.dart';
import 'package:notes/todo/todo.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note});
  final NoteItem note;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: note.color.value,
      child: InkWell(
        onTap: () =>
            context.navigateTo(HomeDetailsRoute(noteId: note.id.value)),
        onLongPress: () {},
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                note.body.value,
                style: const TextStyle(fontSize: 18),
              ),
              if (note.todos.isNotEmpty) ...[
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  children: [...note.todos.map((e) => TodoDisplay(todo: e))],
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class TodoDisplay extends StatelessWidget {
  const TodoDisplay({super.key, required this.todo});
  final TodoItem todo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (todo.done)
          Icon(
            Icons.check_box,
            color: Theme.of(context).colorScheme.secondary,
          ),
        if (!todo.done)
          Icon(
            Icons.check_box_outline_blank,
            color: Theme.of(context).disabledColor,
          ),
        Text(todo.title.value),
      ],
    );
  }
}
