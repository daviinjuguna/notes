import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes/splash/splash.dart';

class MockAuth extends Mock implements MockFirebaseAuth {
  MockAuth({required User? mockUser}) {
    when(() => currentUser).thenReturn(mockUser);
  }
}

void main() {
  late SplashRepoImpl splashRepo;
  late MockAuth mockFirebaseAuth;

  final user = MockUser(
    uid: 'someuid',
    email: 'bob@somedomain.com',
    displayName: 'Bob',
  );

  setUp(() {
    mockFirebaseAuth = MockAuth(mockUser: user);
    splashRepo = SplashRepoImpl(mockFirebaseAuth);
  });

  group('Check if User is signed in', () {
    test('checkIfUserIsLoggedIn returns current user', () async {
      when(() => mockFirebaseAuth.currentUser).thenAnswer((_) => user);

      final result = await splashRepo.checkIfUserIsLoggedIn();

      expect(result, equals(user));
      verify(() => mockFirebaseAuth.currentUser).called(1);
    });

    test('checkIfUserIsLoggedIn returns null on error', () async {
      when(() => mockFirebaseAuth.currentUser)
          .thenThrow(Exception('Test Error'));

      final result = await splashRepo.checkIfUserIsLoggedIn();

      expect(result, isNull);
      verify(() => mockFirebaseAuth.currentUser).called(1);
    });
  });

  group('Logout', () {
    test('logoutUser signs out the user', () async {
      await splashRepo.logoutUser();

      verify(() => mockFirebaseAuth.signOut()).called(1);
    });

    test('logoutUser handles error', () async {
      when(() => mockFirebaseAuth.signOut()).thenThrow(Exception('Test Error'));

      await splashRepo.logoutUser();

      verify(() => mockFirebaseAuth.signOut()).called(1);
    });
  });
}
