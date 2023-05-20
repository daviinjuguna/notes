import 'package:flutter_test/flutter_test.dart';
import 'package:notes/todo/todo.dart';

void main() {
  group('TestModel', () {
    test('equality', () {
      const todo1 = TodoModel(id: '1', title: 'Task 1', done: true);
      const todo2 = TodoModel(id: '1', title: 'Task 1', done: true);
      const todo3 = TodoModel(id: '2', title: 'Task 2', done: false);

      expect(todo1, equals(todo2)); // Same properties, should be equal
      expect(todo1, isNot(equals(todo3))); // Different id, should not be equal
    });

    test('fromJson', () {
      final json = {
        'id': '1',
        'title': 'Task 1',
        'done': true,
      };

      final todo = TodoModel.fromJson(json);

      expect(todo.id, '1');
      expect(todo.title, 'Task 1');
      expect(todo.done, isTrue);
    });
    test('toJson', () {
      const todo = TodoModel(id: '1', title: 'Task 1', done: true);

      final json = todo.toJson();

      expect(json['id'], '1');
      expect(json['title'], 'Task 1');
      expect(json['done'], isTrue);
    });
  });
}
