import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:notes/objects/objects.dart';
import 'package:notes/todo/entity/todo_item.dart';
import 'package:notes/todo/todo_objects/todo_title.dart';

part 'todo_model.g.dart';

@JsonSerializable()
@immutable
class TodoModel {
  const TodoModel({
    required this.id,
    required this.title,
    required this.done,
  });

  @visibleForTesting
  const TodoModel.forTest({
    this.id = '',
    this.title = '',
    this.done = false,
  });

  factory TodoModel.fromEntity(TodoItem entity) {
    return TodoModel(
      id: entity.id.value,
      title: entity.title.value,
      done: entity.done,
    );
  }

  factory TodoModel.fromJson(Map<String, dynamic> data) =>
      _$TodoModelFromJson(data);
  Map<String, dynamic> toJson() => _$TodoModelToJson(this);

  final String id;
  final String title;
  final bool done;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodoModel &&
        other.id == id &&
        other.title == title &&
        other.done == done;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ done.hashCode;
}

extension TodoModelX on TodoModel {
  TodoItem toEntity() {
    return TodoItem(
      id: UniqueId.fromUniqueString(id),
      title: TodoTitle.dirty(title),
      done: done,
    );
  }
}
