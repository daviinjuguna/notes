import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes/splash/splash.dart';

class MockFirebaseUser extends Mock implements User {
  @override
  String? get email => 'test@email.com';
  @override
  String get uid => '10';
}

void main() {
  final user = MockFirebaseUser();
  group('SplashState', () {
    test('supports value comparisons', () {
      expect(const SplashState(), const SplashState());
    });

    test('returns same object when no properties are passed', () {
      expect(const SplashState().copyWith(), const SplashState());
    });

    test('returns object with updated status when status is passed', () {
      expect(
        const SplashState().copyWith(status: SplashStatus.authenticated),
        const SplashState(status: SplashStatus.authenticated),
      );
    });

    test('returns authenticated when authenticated called', () {
      expect(
        SplashState.authenticated(user),
        SplashState(user: user, status: SplashStatus.authenticated),
      );
    });

    test('returns unauthenticated when unauthenticated called', () {
      expect(
        SplashState.unauthenticated(),
        const SplashState(status: SplashStatus.unauthenticated),
      );
    });
  });
}
