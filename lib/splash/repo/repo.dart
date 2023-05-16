import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/di/di.dart';

abstract class SplashRepo {
  Future<User?> checkIfUserIsLoggedIn();
  Future<void> logoutUser();
}

@LazySingleton(as: SplashRepo, env: [Env.dev])
class SplashRepoImpl implements SplashRepo {
  SplashRepoImpl(this._auth);

  final FirebaseAuth _auth;
  @override
  Future<User?> checkIfUserIsLoggedIn() async {
    try {
      return _auth.currentUser;
    } catch (e, s) {
      log('checkIfUserIsLoggedIn error', error: e, stackTrace: s);
      return null;
    }
  }

  @override
  Future<void> logoutUser() async {
    try {
      await _auth.signOut();
    } catch (e, s) {
      log('Logout error', error: e, stackTrace: s);
    }
  }
}
