import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ModuleInjection {
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
  GoogleSignIn get googleSignIn => GoogleSignIn();
}
