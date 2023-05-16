part of 'splash_cubit.dart';

@immutable
class SplashState {
  @visibleForTesting
  const SplashState({this.user, this.status = SplashStatus.initial});

  factory SplashState.initial() => const SplashState();

  factory SplashState.authenticated(User user) => SplashState(
        user: user,
        status: SplashStatus.authenticated,
      );

  factory SplashState.unauthenticated() =>
      const SplashState(status: SplashStatus.unauthenticated);

  final User? user;
  final SplashStatus status;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SplashState && other.user == user && other.status == status;
  }

  @override
  int get hashCode => user.hashCode ^ status.hashCode;

  SplashState copyWith({
    User? user,
    SplashStatus? status,
  }) {
    return SplashState(
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }
}

enum SplashStatus { initial, authenticated, unauthenticated }
