import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:notes/notes/entity/note_item.dart';
import 'package:notes/notes/note_objects/note_body.dart';
import 'package:notes/notes/note_objects/note_color.dart';
import 'package:notes/objects/objects.dart';

import 'package:notes/todo/todo.dart';

part 'note_model.g.dart';

@JsonSerializable()
@immutable
class NoteModel {
  const NoteModel({
    this.id,
    required this.body,
    required this.color,
    this.todos = const [],
    required this.timestamp,
  });

  factory NoteModel.fromEntity(NoteItem entity) {
    return NoteModel(
      id: entity.id.value,
      body: entity.body.value,
      color: entity.color.value?.value ?? const Color(0xfffafafa).value,
      todos: entity.todos.map(TodoModel.fromEntity).toList(),
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
  }

  @visibleForTesting
  const NoteModel.forTest({
    this.id,
    this.body = '',
    this.color = 0,
    this.todos = const [],
    this.timestamp = 0,
  });

  factory NoteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return NoteModel.fromJson(data).copyWith(id: doc.id);
  }

  factory NoteModel.fromJson(Map<String, dynamic> data) =>
      _$NoteModelFromJson(data);
  Map<String, dynamic> toJson() => _$NoteModelToJson(this);

  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? id;
  final String body;
  final int color;
  @JsonKey(toJson: _todosToJson)
  final List<TodoModel> todos;
  final int timestamp;

  static dynamic _todosToJson(List<TodoModel> todos) {
    if (todos.isEmpty) {
      return null;
    }
    return todos.map((e) => e.toJson()).toList();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NoteModel &&
        other.id == id &&
        other.body == body &&
        other.color == color &&
        listEquals(other.todos, todos) &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        body.hashCode ^
        color.hashCode ^
        todos.hashCode ^
        timestamp.hashCode;
  }

  NoteModel copyWith({
    String? id,
    String? body,
    int? color,
    List<TodoModel>? todos,
    int? timestamp,
  }) {
    return NoteModel(
      id: id ?? this.id,
      body: body ?? this.body,
      color: color ?? this.color,
      todos: todos ?? this.todos,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

extension NoteModelX on NoteModel {
  NoteItem toEntity() => NoteItem(
        id: UniqueId.fromUniqueString(id),
        body: NoteBody.dirty(body),
        color: NoteColor.dirty(Color(color)),
        todos: todos.map((e) => e.toEntity()).toList(),
      );
}
