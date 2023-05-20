import 'package:meta/meta.dart';
import 'package:notes/objects/objects.dart';
import 'package:notes/todo/todo_objects/todo_title.dart';

@immutable
class TodoItem {
  const TodoItem({
    required this.id,
    required this.title,
    required this.done,
  });

  factory TodoItem.empty() => TodoItem(
        id: UniqueId(),
        title: const TodoTitle.pure(),
        done: false,
      );

  final UniqueId id;
  final TodoTitle title;
  final bool done;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodoItem &&
        other.id == id &&
        other.title == title &&
        other.done == done;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ done.hashCode;
}
