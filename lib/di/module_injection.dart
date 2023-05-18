import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ModuleInjection {
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
  GoogleSignIn get googleSignIn => GoogleSignIn();
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseDatabase get firebaseDatabase => FirebaseDatabase.instance;
}
