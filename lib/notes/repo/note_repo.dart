import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/notes/entity/note_item.dart';
import 'package:notes/notes/notes.dart';
import 'package:rxdart/rxdart.dart';

abstract class NoteRepo {
  Stream<Either<String, List<NoteItem>>> watchAll();
  Stream<Either<String, List<NoteItem>>> watchUncompleted();
  Future<Either<String, Unit>> create(NoteItem note);
  Future<Either<String, Unit>> update(NoteItem note);
  Future<Either<String, Unit>> delete(NoteItem note);
}

@LazySingleton(as: NoteRepo)
class NoteRepoImpl implements NoteRepo {
  NoteRepoImpl(this._auth, this._firestore);

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  @override
  Stream<Either<String, List<NoteItem>>> watchAll() async* {
    final user = _auth.currentUser;
    if (user == null) {
      yield left('unauthenticated-error');
    }
    yield* _firestore
        .doc('note')
        .collection(user!.uid)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => right<String, List<NoteItem>>(
            snapshot.docs
                .map((doc) => NoteModel.fromFirestore(doc).toEntity())
                .toList(),
          ),
        )
        .onErrorReturnWith((error, stackTrace) {
      log('Watch all error', error: error, stackTrace: stackTrace);
      if (error is PlatformException &&
          (error.message?.contains('PERMISSION_DENIED') ?? false)) {
        return left('permission-error');
      } else {
        return left('default-error');
      }
    });
  }

  @override
  Stream<Either<String, List<NoteItem>>> watchUncompleted() async* {
    final user = _auth.currentUser;
    if (user == null) {
      yield left('unauthenticated-error');
    }

    yield* _firestore
        .doc('note')
        .collection(user!.uid)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => NoteModel.fromFirestore(doc).toEntity()),
        )
        .map(
          (notes) => right<String, List<NoteItem>>(
            notes
                .where((note) => note.todos.any((todo) => !todo.done))
                .toList(),
          ),
        )
        .onErrorReturnWith((error, stackTrace) {
      log('Watch all error', error: error, stackTrace: stackTrace);
      if (error is PlatformException &&
          (error.message?.contains('PERMISSION_DENIED') ?? false)) {
        return left('permission-error');
      } else {
        return left('default-error');
      }
    });
  }

  @override
  Future<Either<String, Unit>> create(NoteItem note) async {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<Either<String, Unit>> update(NoteItem note) async {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<Either<String, Unit>> delete(NoteItem note) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  Future<Either<String, Unit>> _crudAction(Future<void> firebaseCall) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return left('unauthenticated-error');
      }
      await firebaseCall;
      return right(unit);
    } catch (error, stackTrace) {
      log('Watch all error', error: error, stackTrace: stackTrace);
      if (error is PlatformException &&
          (error.message?.contains('PERMISSION_DENIED') ?? false)) {
        return left('permission-error');
      } else {
        return left('default-error');
      }
    }
  }
}
