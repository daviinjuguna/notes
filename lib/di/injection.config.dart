// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas, cascade_invocations
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:notes/auth/cubit/auth_cubit.dart' as _i9;
import 'package:notes/auth/repo/auth_repo.dart' as _i7;
import 'package:notes/di/module_injection.dart' as _i10;
import 'package:notes/splash/cubit/splash_cubit.dart' as _i8;
import 'package:notes/splash/repo/repo.dart' as _i5;
import 'package:notes/theme/cubit/theme_cubit.dart' as _i6;

const String _dev = 'dev';

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final moduleInjection = _$ModuleInjection();
    gh.factory<_i3.FirebaseAuth>(() => moduleInjection.firebaseAuth);
    gh.factory<_i4.GoogleSignIn>(() => moduleInjection.googleSignIn);
    gh.lazySingleton<_i5.SplashRepo>(
      () => _i5.SplashRepoImpl(gh<_i3.FirebaseAuth>()),
      registerFor: {_dev},
    );
    gh.factory<_i6.ThemeCubit>(
      () => _i6.ThemeCubit(),
      registerFor: {_dev},
    );
    gh.lazySingleton<_i7.AuthRepo>(
      () => _i7.AuthRepoImpl(
        gh<_i3.FirebaseAuth>(),
        gh<_i4.GoogleSignIn>(),
      ),
      registerFor: {_dev},
    );
    gh.factory<_i8.SplashCubit>(
      () => _i8.SplashCubit(gh<_i5.SplashRepo>()),
      registerFor: {_dev},
    );
    gh.factory<_i9.AuthCubit>(
      () => _i9.AuthCubit(gh<_i7.AuthRepo>()),
      registerFor: {_dev},
    );
    return this;
  }
}

class _$ModuleInjection extends _i10.ModuleInjection {}
