part of 'auth_cubit.dart';

@immutable
class AuthState {
  const AuthState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
    this.errorCode,
    this.user,
  });
  final FormzSubmissionStatus status;
  final Email email;
  final Password password;
  final bool isValid;
  final String? errorCode;
  final User? user;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthState &&
        other.status == status &&
        other.email == email &&
        other.password == password &&
        other.isValid == isValid &&
        other.errorCode == errorCode &&
        other.user == user;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        email.hashCode ^
        password.hashCode ^
        isValid.hashCode ^
        errorCode.hashCode ^
        user.hashCode;
  }

  AuthState copyWith({
    FormzSubmissionStatus? status,
    Email? email,
    Password? password,
    bool? isValid,
    String? errorCode,
    User? user,
  }) {
    return AuthState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      errorCode: errorCode ?? this.errorCode,
      user: user ?? this.user,
    );
  }
}
