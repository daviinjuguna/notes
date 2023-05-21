// Define your mock classes based on the necessary Firebase and model classes
// Example:
// ignore_for_file: subtype_of_sealed_class

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes/notes/notes.dart';
import 'package:notes/todo/todo.dart';

class MockUser extends Mock implements User {}

class MockQuerySnapshot extends Mock implements QuerySnapshot {}

class MockDocumentSnapshot extends Mock implements DocumentSnapshot {}

class MockNoteModel extends Mock implements NoteModel {}

class MockNoteItem extends Mock implements NoteItem {}

class MockTodoItem extends Mock implements TodoItem {}

// Define your mock classes for the Firebase-related classes
// Example:
class MockDocumentReference extends Mock implements DocumentReference {}

class MockCollectionReference extends Mock implements CollectionReference {}

class MockQuery extends Mock implements Query {}

// Create a mock implementation of FirebaseAuth
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

// Create a mock implementation of FirebaseFirestore
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  setUp(() {
    // Create new instances of the mocks and the NoteRepoImpl class
  });
}
