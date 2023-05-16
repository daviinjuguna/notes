import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:notes/di/di.dart';
import 'package:notes/splash/repo/repo.dart';

part 'splash_state.dart';

@Injectable(env: [Env.dev])
class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._repo) : super(SplashState.initial());
  final SplashRepo _repo;

  Future<void> checkAuth() async {
    final user = await _repo.checkIfUserIsLoggedIn();
    if (user != null) {
      emit(SplashState.authenticated(user));
    } else {
      emit(SplashState.unauthenticated());
    }
  }

  Future<void> logout() async {
    await _repo.logoutUser();
    emit(SplashState.unauthenticated());
  }
}
