import 'package:flutter/foundation.dart';
import 'package:notes/notes/note_objects/note_body.dart';
import 'package:notes/notes/note_objects/note_color.dart';
import 'package:notes/objects/objects.dart';
import 'package:notes/todo/todo.dart';
import 'package:notes/utils/utils.dart';

@immutable
class NoteItem {
  const NoteItem({
    required this.id,
    required this.body,
    required this.color,
    required this.todos,
  });

  factory NoteItem.empty() => NoteItem(
        id: UniqueId(),
        body: const NoteBody.pure(),
        color:  NoteColor.dirty(AppColor.noteColors.firstOrNull),
        todos: const [],
      );

  final UniqueId id;
  final NoteBody body;
  final NoteColor color;
  final List<TodoItem> todos;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          body == other.body &&
          color == other.color &&
          listEquals(todos, other.todos);

  @override
  int get hashCode =>
      id.hashCode ^ body.hashCode ^ color.hashCode ^ todos.hashCode;
}
