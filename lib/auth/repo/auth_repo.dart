import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/di/di.dart';

abstract class AuthRepo {
  Future<Either<String, User>> loginWithEmailAndPassword(
    String email,
    String password,
  );
  Future<Either<String, User>> registerWithEmailAndPassword(
    String email,
    String password,
  );
  Future<Either<String, User>> signInWithGoogle();
}

@LazySingleton(as: AuthRepo, env: [Env.dev])
class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl(this._firebaseAuth, this._googleSignIn);

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  @override
  Future<Either<String, User>> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return left(e.code);
    } catch (e,s) {
      log('Sign in error',error: e,stackTrace: s);
      return left('default-code');
    }
  }

  @override
  Future<Either<String, User>> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return left(e.code);
    } catch (e,s) {
      log('Sign up error',error: e,stackTrace: s);
      return left('default-code');
    }
  }

  @override
  Future<Either<String, User>> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return left('google-sign-in-cancelled');
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      return right(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return left(e.code);
    } catch (e,s) {
      log('Sign in with google error',error: e,stackTrace: s);
      return left('default-code');
    }
  }
}
