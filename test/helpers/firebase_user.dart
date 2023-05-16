import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseUser extends Mock implements User {
  @override
  String? get email => 'test@email.com';
  @override
  String get uid => '10';
}
