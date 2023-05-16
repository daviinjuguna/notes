import 'package:dartz_test/dartz_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes/auth/repo/auth_repo.dart';

import '../../helpers/helpers.dart';

class MockAuth extends Mock implements MockFirebaseAuth {
  MockAuth({required User? mockUser}) {
    when(() => currentUser).thenReturn(mockUser);
  }
}

class MockGoogleAuth extends Mock implements GoogleSignIn {}

class MockUserCredential extends Mock implements UserCredential {
  MockUserCredential({required User? mockUser}) {
    when(() => user).thenReturn(mockUser);
  }
}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {}

void main() {
  late AuthRepo authRepo;

  final user = MockUser(
    uid: 'someuid',
    email: 'bob@somedomain.com',
    displayName: 'Bob',
  );

  final mockUser = MockFirebaseUser();
  final mockCredentials = MockUserCredential(
    mockUser: user,
  );
  final mockGoogleSignIn = MockGoogleAuth();
  final firebaseAuthMock = MockAuth(mockUser: user);

  final mockGoogleUser = MockGoogleSignInAccount();
  final mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();

  setUp(() {
    authRepo = AuthRepoImpl(
      firebaseAuthMock,
      mockGoogleSignIn,
    );
  });

  group('Login with credentials', () {
    test(
      'should return user on successful login',
      () async {
        // Arrange
        const email = 'bob@somedomain.com';
        const password = 'somedomain';

        when(
          () => firebaseAuthMock.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((invocation) async => mockCredentials);

        when(() => mockCredentials.user).thenAnswer((_) => mockUser);

        // Act
        final result =
            await authRepo.loginWithEmailAndPassword(email, password);

        result.fold(
          (l) => null,
          (r) => expect(r, mockUser),
        );

        verify(
          () => firebaseAuthMock.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).called(1);
        verify(() => mockCredentials.user).called(1);

        verifyNoMoreInteractions(firebaseAuthMock);
      },
    );

    test(
      'should return error code on FirebaseAuthException',
      () async {
        // Arrange
        const email = 'bob@somedomain.com';
        const password = 'somedomain';
        const errorCode = 'invalid-email';

        when(
          () => firebaseAuthMock.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(FirebaseAuthException(code: errorCode));

        // Act
        final result =
            await authRepo.loginWithEmailAndPassword(email, password);

        result.fold(
          (l) => expect(l, equals(errorCode)),
          (r) => null,
        );
        verify(
          () => firebaseAuthMock.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).called(1);
        verifyNoMoreInteractions(firebaseAuthMock);
      },
    );

    test('should return default error code on unknown exception', () async {
      //arrange
      const email = 'bob@somedomain.com';
      const password = 'somedomain';
      const defaultErrorCode = 'default-code';

      when(
        () => firebaseAuthMock.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(Exception());

      // Act
      final result = await authRepo.loginWithEmailAndPassword(email, password);

      result.fold(
        (l) => expect(l, equals(defaultErrorCode)),
        (r) => null,
      );
      verify(
        () => firebaseAuthMock.signInWithEmailAndPassword(
          email: email,
          password: password,
        ),
      ).called(1);
      verifyNoMoreInteractions(firebaseAuthMock);
    });
  });

  group('Register with credentials', () {
    test(
      'should return user on successful register',
      () async {
        // Arrange
        const email = 'bob@somedomain.com';
        const password = 'somedomain';

        when(
          () => firebaseAuthMock.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((invocation) async => mockCredentials);

        when(() => mockCredentials.user).thenAnswer((_) => mockUser);

        // Act
        final result =
            await authRepo.registerWithEmailAndPassword(email, password);

        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(result.getRightOrFailTest(), mockUser);

        verify(
          () => firebaseAuthMock.createUserWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).called(1);
        verify(() => mockCredentials.user).called(1);

        verifyNoMoreInteractions(firebaseAuthMock);
      },
    );

    test(
      'should return error code on FirebaseAuthException',
      () async {
        // Arrange
        const email = 'bob@somedomain.com';
        const password = 'somedomain';
        const errorCode = 'invalid-email';

        when(
          () => firebaseAuthMock.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(FirebaseAuthException(code: errorCode));

        // Act
        final result =
            await authRepo.registerWithEmailAndPassword(email, password);

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result.getLeftOrFailTest(), errorCode);

        verify(
          () => firebaseAuthMock.createUserWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).called(1);
        verifyNoMoreInteractions(firebaseAuthMock);
      },
    );

    test('should return default error code on unknown exception', () async {
      //arrange
      const email = 'bob@somedomain.com';
      const password = 'somedomain';
      const defaultErrorCode = 'default-code';

      when(
        () => firebaseAuthMock.createUserWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(Exception());

      // Act
      final result =
          await authRepo.registerWithEmailAndPassword(email, password);

      expect(result.isLeft(), true);
      expect(result.isRight(), false);
      expect(result.getLeftOrFailTest(), defaultErrorCode);

      verify(
        () => firebaseAuthMock.createUserWithEmailAndPassword(
          email: email,
          password: password,
        ),
      ).called(1);
      verifyNoMoreInteractions(firebaseAuthMock);
    });
  });

  group('Sign in with google', () {
    test('should return user on successful sign-in', () async {
      //arrange
      when(mockGoogleSignIn.signIn).thenAnswer((_) async => mockGoogleUser);
      when(() => mockGoogleUser.authentication)
          .thenAnswer((_) async => mockGoogleSignInAuthentication);
      when(() => mockGoogleSignInAuthentication.accessToken)
          .thenReturn('access-token');
      when(() => mockGoogleSignInAuthentication.idToken).thenReturn('id-token');
      when(() => firebaseAuthMock.signInWithCredential(any()))
          .thenAnswer((_) async => mockCredentials);
      when(() => mockCredentials.user).thenReturn(mockUser);

      // Act
      final result = await authRepo.signInWithGoogle();

      expect(result.isLeft(), false);
      expect(result.isRight(), true);
      expect(result.getRightOrFailTest(), mockUser);

      verify(mockGoogleSignIn.signIn).called(1);
      verify(() => mockGoogleUser.authentication).called(1);
      verify(
        () => firebaseAuthMock.signInWithCredential(
          any(that: isInstanceOf<GoogleAuthCredential>()),
        ),
      ).called(1);
      verify(() => mockCredentials.user).called(1);

      // verifyNoMoreInteractions(firebaseAuthMock);
    });

    test('should return error code when Google sign-in is cancelled', () async {
      // Arrange
      const MockGoogleSignInAccount? mockGoogleUserNull =
          null; // Simulating null when sign-in is cancelled.
      when(mockGoogleSignIn.signIn).thenAnswer((_) async => mockGoogleUserNull);

      // Act
      final result = await authRepo.signInWithGoogle();

      // Assert
      expect(result.isRight(), false);
      expect(result.isLeft(), true);
      expect(result.getLeftOrFailTest(), equals('google-sign-in-cancelled'));

      verify(mockGoogleSignIn.signIn).called(1);
    });

    test('returns error code when Firebase sign-in fails', () async {
      const errorCode = 'firebase-error-code';
      //mock success google sign in
      when(mockGoogleSignIn.signIn).thenAnswer((_) async => mockGoogleUser);
      when(() => mockGoogleUser.authentication)
          .thenAnswer((_) async => mockGoogleSignInAuthentication);
      when(() => mockGoogleSignInAuthentication.accessToken)
          .thenReturn('access-token');
      when(() => mockGoogleSignInAuthentication.idToken).thenReturn('id-token');

      //mock firebase error
      when(() => firebaseAuthMock.signInWithCredential(any()))
          .thenThrow(FirebaseAuthException(code: errorCode));

      //act
      final result = await authRepo.signInWithGoogle();

      //assert
      expect(result.isRight(), false);
      expect(result.isLeft(), true);
      expect(result.getLeftOrFailTest(), equals(errorCode));

      verify(mockGoogleSignIn.signIn).called(1);
      verify(() => mockGoogleUser.authentication).called(1);
      verify(
        () => firebaseAuthMock.signInWithCredential(
          any(that: isInstanceOf<GoogleAuthCredential>()),
        ),
      ).called(1);
    });

    test('returns default error code when an unexpected error occurs',
        () async {
      const defaultErrorCode = 'default-code';
      //mock success google sign in
      when(mockGoogleSignIn.signIn).thenAnswer((_) async => mockGoogleUser);
      when(() => mockGoogleUser.authentication)
          .thenAnswer((_) async => mockGoogleSignInAuthentication);
      when(() => mockGoogleSignInAuthentication.accessToken)
          .thenReturn('access-token');
      when(() => mockGoogleSignInAuthentication.idToken).thenReturn('id-token');

      //mock firebase error
      when(() => firebaseAuthMock.signInWithCredential(any()))
          .thenThrow(Exception());

      //act
      final result = await authRepo.signInWithGoogle();

      //assert
      expect(result.isRight(), false);
      expect(result.isLeft(), true);
      expect(result.getLeftOrFailTest(), equals(defaultErrorCode));

      verify(mockGoogleSignIn.signIn).called(1);
      verify(() => mockGoogleUser.authentication).called(1);
      verify(
        () => firebaseAuthMock.signInWithCredential(
          any(that: isInstanceOf<GoogleAuthCredential>()),
        ),
      ).called(1);
    });
  });
}
