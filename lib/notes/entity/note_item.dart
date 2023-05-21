// ignore_for_file: no_default_cases

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import 'package:notes/notes/note_objects/note_body.dart';
import 'package:notes/notes/note_objects/note_color.dart';
import 'package:notes/objects/objects.dart';
import 'package:notes/todo/todo.dart';
import 'package:notes/todo/todo_objects/todo_title.dart';
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
        color: NoteColor.dirty(AppColor.noteColors.firstOrNull),
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

  NoteItem copyWith({
    UniqueId? id,
    NoteBody? body,
    NoteColor? color,
    List<TodoItem>? todos,
  }) {
    return NoteItem(
      id: id ?? this.id,
      body: body ?? this.body,
      color: color ?? this.color,
      todos: todos ?? this.todos,
    );
  }
}

extension NoteItemX on NoteItem {
  //validates the note item
  //returns a failure if the note item is invalid
  bool get failedValidation {
    return body.isNotValid ||
        todos.any((todo) => todo.title.isNotValid) ||
        color.isNotValid;
  }

  String get validationError {
    if (body.isNotValid) {
      switch (body.error) {
        case NoteBodyValidationErrors.empty:
          return 'note-empty';
        case NoteBodyValidationErrors.tooLong:
          return 'note-too-long';
        default:
          return 'note-invalid';
      }
    } else if (todos.any((todo) => todo.title.isNotValid)) {
      final invalidTitle =
          todos.firstWhere((todo) => todo.title.isNotValid).title;
      switch (invalidTitle.error) {
        case TodoTitleValidationErrors.empty:
          return 'todo-empty';
        case TodoTitleValidationErrors.tooLong:
          return 'todo-too-long';
        default:
          return 'todo-invalid';
      }
    } else if (color.isNotValid) {
      return 'color-invalid';
    } else {
      return '';
    }
  }
}
