// ignore_for_file: avoid_dynamic_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes/notes/notes.dart';
import 'package:notes/todo/todo.dart';

// ignore: subtype_of_sealed_class
class MockDocumentSnapshot extends Mock implements DocumentSnapshot {}

void main() {
  group('NoteModel', () {
    test('equality', () {
      const note1 = NoteModel(
        id: '1',
        body: 'Sample note',
        color: 1,
        todos: [
          TodoModel(id: '1', title: 'Task 1', done: false),
          TodoModel(id: '2', title: 'Task 2', done: true),
        ],
        timestamp: 1621454532000,
      );
      const note2 = NoteModel(
        id: '1',
        body: 'Sample note',
        color: 1,
        todos: [
          TodoModel(id: '1', title: 'Task 1', done: false),
          TodoModel(id: '2', title: 'Task 2', done: true),
        ],
        timestamp: 1621454532000,
      );
      const note3 = NoteModel(
        id: '1',
        body: 'Sample notes',
        color: 1,
        todos: [
          TodoModel(id: '4', title: 'Task 1', done: false),
          TodoModel(id: '2', title: 'Task 2', done: true),
        ],
        timestamp: 1621454532000,
      );

      expect(note1, note2);
      expect(note1, isNot(note3));
    });

    test('CopyWith creates a new instance with the provided values', () {
      const originalNote = NoteModel(
        id: '1',
        body: 'Sample note',
        color: 1,
        todos: [
          TodoModel(id: '1', title: 'Task 1', done: false),
          TodoModel(id: '2', title: 'Task 2', done: true),
        ],
        timestamp: 1621454532000,
      );

      final copiedNote = originalNote.copyWith(
        body: 'Updated note',
        color: 2,
        todos: [
          const TodoModel(id: '3', title: 'Task 3', done: false),
        ],
        timestamp: 1621454533000,
      );

      expect(copiedNote.id, originalNote.id);
      expect(copiedNote.body, 'Updated note');
      expect(copiedNote.color, 2);
      expect(copiedNote.todos.length, 1);
      expect(copiedNote.todos[0].id, '3');
      expect(copiedNote.timestamp, 1621454533000);
    });

    test('fromJson', () {
      final json = {
        'body': 'Sample note',
        'color': 1,
        'todos': [
          {
            'id': '1',
            'title': 'Task 1',
            'done': false,
          },
          {
            'id': '2',
            'title': 'Task 2',
            'done': true,
          },
        ],
        'timestamp': 1621454532000,
      };

      final note = NoteModel.fromJson(json);
      expect(note.id, null); // id is not included in the json
      expect(note.body, 'Sample note');
      expect(note.color, 1);
      expect(note.todos.length, 2);
      expect(note.todos[0].id, '1');
      expect(note.timestamp, 1621454532000);
    });

    test('toJson', () {
      const note1 = NoteModel(
        id: '1',
        body: 'Sample note',
        color: 1,
        todos: [
          TodoModel(id: '1', title: 'Task 1', done: false),
          TodoModel(id: '2', title: 'Task 2', done: true),
        ],
        timestamp: 1621454532000,
      );

      final json = note1.toJson();
      expect(json['id'], null); // id is not included in the json
      expect(json['body'], 'Sample note');
      expect(json['color'], 1);
      expect(json['todos'].length, 2);
      expect(json['todos'][0], isA<TodoModel>());
      expect(json['timestamp'], 1621454532000);
    });

    test('FromFirestore returns a NoteModel instance with the provided data',
        () {
      final docSnapshot = MockDocumentSnapshot();
      when(docSnapshot.data).thenReturn({
        'body': 'Sample note',
        'color': 1,
        'todos': [
          {
            'id': '1',
            'title': 'Task 1',
            'done': false,
          },
          {
            'id': '2',
            'title': 'Task 2',
            'done': true,
          },
        ],
        'timestamp': 1621454532000,
      });
      when(() => docSnapshot.id).thenReturn('1');

      final note = NoteModel.fromFirestore(docSnapshot);
      expect(note.id, '1');
      expect(note.body, 'Sample note');
      expect(note.color, 1);
      expect(note.todos.length, 2);
      expect(note.todos[0].id, '1');
      expect(note.timestamp, 1621454532000);
    });
  });
}
