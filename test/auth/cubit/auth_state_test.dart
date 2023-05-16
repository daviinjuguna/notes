import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:notes/auth/auth.dart';

void main() {
  const email = Email.dirty('email');
  const password = Password.dirty('password');

  group('AuthState', () {
    test('supports value comparisons', () {
      expect(const AuthState(), const AuthState());
    });
    test('returns same object when no properties are passed', () {
      expect(const AuthState().copyWith(), const AuthState());
    });
    test('returns object with updated status when status is passed', () {
      expect(
        const AuthState().copyWith(status: FormzSubmissionStatus.initial),
        const AuthState(),
      );
    });

    test('returns object with updated email when email is passed', () {
      expect(
        const AuthState().copyWith(email: email),
        const AuthState(email: email),
      );
    });

    test('returns object with updated password when password is passed', () {
      expect(
        const AuthState().copyWith(password: password),
        const AuthState(password: password),
      );
    });
  });
}
