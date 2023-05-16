import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes/splash/splash.dart';

import '../../helpers/helpers.dart';

void main() {
  late SplashCubit splashCubit;
  late MockSplashRepo mockRepo;

  setUp(() {
    mockRepo = MockSplashRepo();
    splashCubit = SplashCubit(mockRepo);
  });

  tearDown(() {
    splashCubit.close();
  });

  group('SplashCubit', () {
    final mockUser = MockFirebaseUser();

    test('initial state is correct', () {
      expect(splashCubit.state, equals(SplashState.initial()));
    });

    blocTest<SplashCubit, SplashState>(
      'emits authenticated state when user is logged in',
      build: () {
        when(() => mockRepo.checkIfUserIsLoggedIn())
            .thenAnswer((_) async => mockUser);
        return splashCubit;
      },
      act: (cubit) => cubit.checkAuth(),
      expect: () => [SplashState.authenticated(mockUser)],
    );

    blocTest<SplashCubit, SplashState>(
      'emits unauthenticated state when user is not logged in',
      build: () {
        when(() => mockRepo.checkIfUserIsLoggedIn())
            .thenAnswer((_) async => null);
        return splashCubit;
      },
      act: (cubit) => cubit.checkAuth(),
      expect: () => [SplashState.unauthenticated()],
    );
  });
}
