import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/notes/notes.dart';
import 'package:notes/todo/entity/todo_item.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  late List<TodoItem> _todoItem =
      context.read<NoteFormCubit>().state.note.todos;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NoteFormCubit, NoteFormState>(
          listenWhen: (p, c) => p.isEditing != c.isEditing,
          listener: (context, state) {
            _todoItem = state.note.todos;
          },
        ),
      ],
      child: BlocBuilder<NoteFormCubit, NoteFormState>(
        builder: (context, state) {
          return ReorderableListView.builder(
            itemCount: _todoItem.length,
            padding: const EdgeInsets.all(3),
            shrinkWrap: true,
            onReorder: (oldIndex, newIndex) {},
            proxyDecorator: (child, index, animation) {
              final elevation = lerpDouble(0, 8, animation.value);
              return ScaleTransition(
                scale: Tween<double>(begin: 1, end: 0.95).animate(animation),
                child: Material(
                  elevation: elevation ?? 0.0,
                  animationDuration: const Duration(milliseconds: 100),
                  borderRadius: BorderRadius.circular(8),
                  child: child,
                ),
              );
            },
            itemBuilder: (_, int index) {
              final todo = _todoItem.elementAt(index);
              return Container(
                key: ValueKey(todo.id.value),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  leading: Checkbox(
                    value: todo.done,
                    onChanged: (_) {},
                  ),
                  title: TextFormField(
                    initialValue: todo.title.value,
                    enabled: false,
                    decoration: const InputDecoration(
                      hintText: 'Todo',
                      counterText: '',
                      border: InputBorder.none,
                    ),
                    maxLength: 100,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
