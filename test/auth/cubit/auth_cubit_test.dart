import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes/auth/auth.dart';
import 'package:notes/auth/repo/auth_repo.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

class MockUser extends Mock implements User {}

void main() {
  late AuthRepo mockRepo;
  final mockUser = MockUser();
  const invalidEmailString = 'invalid';
  const invalidEmail = Email.dirty(invalidEmailString);

  const validEmailString = 'test@gmail.com';
  const validEmail = Email.dirty(validEmailString);

  const invalidPasswordString = 'invalid';
  const invalidPassword = Password.dirty(invalidPasswordString);

  const validPasswordString = 't0pS3cret1234';
  const validPassword = Password.dirty(validPasswordString);

  setUp(() {
    mockRepo = MockAuthRepo();
    when(() => mockRepo.loginWithEmailAndPassword(any(), any()))
        .thenAnswer((_) async => right(mockUser));
    when(() => mockRepo.registerWithEmailAndPassword(any(), any()))
        .thenAnswer((_) async => right(mockUser));
    when(() => mockRepo.signInWithGoogle())
        .thenAnswer((_) async => right(mockUser));
  });

  test('Initial login state', () {
    expect(AuthCubit(mockRepo).state, const AuthState());
  });

  group('Email Changed', () {
    blocTest<AuthCubit, AuthState>(
      'emits [invalid] when email/password are invalid',
      build: () => AuthCubit(mockRepo),
      act: (bloc) => bloc.emailChanged(invalidEmailString),
      expect: () => const <AuthState>[AuthState(email: invalidEmail)],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [valid] when email/password are valid',
      build: () => AuthCubit(mockRepo),
      seed: () => const AuthState(password: validPassword),
      act: (cubit) => cubit.emailChanged(validEmailString),
      expect: () => const <AuthState>[
        AuthState(
          email: validEmail,
          password: validPassword,
          isValid: true,
        ),
      ],
    );
  });

  group('Password Changed', () {
    blocTest<AuthCubit, AuthState>(
      'emits [invalid] when email/password are invalid',
      build: () => AuthCubit(mockRepo),
      act: (bloc) => bloc.passChanged(invalidPasswordString),
      expect: () => const <AuthState>[AuthState(password: invalidPassword)],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [valid] when email/password are valid',
      build: () => AuthCubit(mockRepo),
      seed: () => const AuthState(email: validEmail),
      act: (cubit) => cubit.passChanged(validPasswordString),
      expect: () => const <AuthState>[
        AuthState(
          email: validEmail,
          password: validPassword,
          isValid: true,
        ),
      ],
    );
  });

  group('Login with credentials', () {
    blocTest<AuthCubit, AuthState>(
      'does nothing when status is not validated',
      build: () => AuthCubit(mockRepo),
      act: (cubit) => cubit.loginUser(),
      expect: () => const <AuthState>[],
    );

    blocTest<AuthCubit, AuthState>(
      'calls loginWithEmailAndPassword with correct email/password',
      build: () => AuthCubit(mockRepo),
      seed: () => const AuthState(
        email: validEmail,
        password: validPassword,
        isValid: true,
      ),
      act: (cubit) => cubit.loginUser(),
      verify: (_) {
        verify(
          () => mockRepo.loginWithEmailAndPassword(
            validEmailString,
            validPasswordString,
          ),
        ).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'emits [submissionInProgress, submissionSuccess] '
      'when logInWithEmailAndPassword succeeds',
      build: () => AuthCubit(mockRepo),
      seed: () => const AuthState(
        email: validEmail,
        password: validPassword,
        isValid: true,
      ),
      act: (cubit) => cubit.loginUser(),
      expect: () => <AuthState>[
        const AuthState(
          status: FormzSubmissionStatus.inProgress,
          email: validEmail,
          password: validPassword,
          isValid: true,
        ),
        AuthState(
          status: FormzSubmissionStatus.success,
          email: validEmail,
          password: validPassword,
          isValid: true,
          user: mockUser,
        )
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [submissionInProgress, submissionFailure] '
      'when logInWithEmailAndPassword fails '
      'result in left',
      setUp: () {
        when(
          () => mockRepo.loginWithEmailAndPassword(any(), any()),
        ).thenAnswer((_) async => left('error-code'));
      },
      build: () => AuthCubit(mockRepo),
      seed: () => const AuthState(
        email: validEmail,
        password: validPassword,
        isValid: true,
      ),
      act: (cubit) => cubit.loginUser(),
      expect: () => const <AuthState>[
        AuthState(
          status: FormzSubmissionStatus.inProgress,
          email: validEmail,
          password: validPassword,
          isValid: true,
        ),
        AuthState(
          status: FormzSubmissionStatus.failure,
          errorCode: 'error-code',
          email: validEmail,
          password: validPassword,
          isValid: true,
        )
      ],
    );
  });

  group('Register User with credentials', () {
    blocTest<AuthCubit, AuthState>(
      'does nothing when status is not validated',
      build: () => AuthCubit(mockRepo),
      act: (cubit) => cubit.registerUser(),
      expect: () => const <AuthState>[],
    );

    blocTest<AuthCubit, AuthState>(
      'calls registerWithEmailAndPassword with correct email/password',
      build: () => AuthCubit(mockRepo),
      seed: () => const AuthState(
        email: validEmail,
        password: validPassword,
        isValid: true,
      ),
      act: (cubit) => cubit.registerUser(),
      verify: (_) {
        verify(
          () => mockRepo.registerWithEmailAndPassword(
            validEmailString,
            validPasswordString,
          ),
        ).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'emits [submissionInProgress, submissionSuccess] '
      'when registerWithEmailAndPassword succeeds',
      build: () => AuthCubit(mockRepo),
      seed: () => const AuthState(
        email: validEmail,
        password: validPassword,
        isValid: true,
      ),
      act: (cubit) => cubit.registerUser(),
      expect: () => <AuthState>[
        const AuthState(
          status: FormzSubmissionStatus.inProgress,
          email: validEmail,
          password: validPassword,
          isValid: true,
        ),
        AuthState(
          status: FormzSubmissionStatus.success,
          email: validEmail,
          password: validPassword,
          isValid: true,
          user: mockUser,
        )
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [submissionInProgress, submissionFailure] '
      'when registerWithEmailAndPassword fails '
      'result in left',
      setUp: () {
        when(
          () => mockRepo.registerWithEmailAndPassword(any(), any()),
        ).thenAnswer((_) async => left('error-code'));
      },
      build: () => AuthCubit(mockRepo),
      seed: () => const AuthState(
        email: validEmail,
        password: validPassword,
        isValid: true,
      ),
      act: (cubit) => cubit.registerUser(),
      expect: () => const <AuthState>[
        AuthState(
          status: FormzSubmissionStatus.inProgress,
          email: validEmail,
          password: validPassword,
          isValid: true,
        ),
        AuthState(
          status: FormzSubmissionStatus.failure,
          errorCode: 'error-code',
          email: validEmail,
          password: validPassword,
          isValid: true,
        )
      ],
    );
  });

  group('Sign in with google', () {
    blocTest<AuthCubit, AuthState>(
      'calls signInWithGoogle',
      build: () => AuthCubit(mockRepo),
      act: (cubit) => cubit.signInWithGoogle(),
      verify: (_) {
        verify(
          () => mockRepo.signInWithGoogle(),
        ).called(1);
      },
    );
    blocTest<AuthCubit, AuthState>(
      'emits [submissionInProgress, submissionSuccess] '
      'when signInWithGoogle succeeds',
      build: () => AuthCubit(mockRepo),
      act: (cubit) => cubit.signInWithGoogle(),
      expect: () => <AuthState>[
        const AuthState(
          status: FormzSubmissionStatus.inProgress,
        ),
        AuthState(
          status: FormzSubmissionStatus.success,
          user: mockUser,
        )
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [submissionInProgress, submissionFailure] '
      'when signInWithGoogle fails '
      'result in left',
      setUp: () {
        when(
          () => mockRepo.signInWithGoogle(),
        ).thenAnswer((_) async => left('error-code'));
      },
      build: () => AuthCubit(mockRepo),
      act: (cubit) => cubit.signInWithGoogle(),
      expect: () => const <AuthState>[
        AuthState(
          status: FormzSubmissionStatus.inProgress,
        ),
        AuthState(
          status: FormzSubmissionStatus.failure,
          errorCode: 'error-code',
        )
      ],
    );
  });
}
