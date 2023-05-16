import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:notes/auth/auth.dart';
import 'package:notes/auth/repo/auth_repo.dart';
import 'package:notes/di/di.dart';

part 'auth_state.dart';

@Injectable(env: [Env.dev])
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepo) : super(const AuthState());
  final AuthRepo _authRepo;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password]),
      ),
    );
  }

  void passChanged(String value) {
    final pass = Password.dirty(value);
    emit(
      state.copyWith(
        password: pass,
        isValid: Formz.validate([state.email, pass]),
      ),
    );
  }

  Future<void> loginUser() async {
    if (state.isValid == false) return;
    return _repoAuth(
      _authRepo.loginWithEmailAndPassword(
        state.email.value,
        state.password.value,
      ),
    );
  }

  Future<void> registerUser() async {
    if (state.isValid == false) return;
    return _repoAuth(
      _authRepo.registerWithEmailAndPassword(
        state.email.value,
        state.password.value,
      ),
    );
  }

  Future<void> signInWithGoogle() => _repoAuth(_authRepo.signInWithGoogle());

  Future<void> _repoAuth(Future<Either<String, User>> repoFunction) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final results = await repoFunction;
    emit(
      results.fold(
        (code) => state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorCode: code,
        ),
        (user) => state.copyWith(
          status: FormzSubmissionStatus.success,
          user: user,
        ),
      ),
    );
  }
}
