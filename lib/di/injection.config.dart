// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:firebase_database/firebase_database.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i6;
import 'package:injectable/injectable.dart' as _i2;
import 'package:notes/auth/cubit/auth_cubit.dart' as _i16;
import 'package:notes/auth/repo/auth_repo.dart' as _i11;
import 'package:notes/di/module_injection.dart' as _i17;
import 'package:notes/notes/bloc/note_actor/note_actor_cubit.dart' as _i12;
import 'package:notes/notes/bloc/note_form/note_form_cubit.dart' as _i14;
import 'package:notes/notes/bloc/note_watcher/note_watcher_bloc.dart' as _i8;
import 'package:notes/notes/notes.dart' as _i13;
import 'package:notes/notes/repo/note_repo.dart' as _i7;
import 'package:notes/splash/cubit/splash_cubit.dart' as _i15;
import 'package:notes/splash/repo/repo.dart' as _i9;
import 'package:notes/theme/cubit/theme_cubit.dart' as _i10;

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
    gh.factory<_i4.FirebaseDatabase>(() => moduleInjection.firebaseDatabase);
    gh.factory<_i5.FirebaseFirestore>(() => moduleInjection.firestore);
    gh.factory<_i6.GoogleSignIn>(() => moduleInjection.googleSignIn);
    gh.lazySingleton<_i7.NoteRepo>(() => _i7.NoteRepoImpl(
          gh<_i3.FirebaseAuth>(),
          gh<_i5.FirebaseFirestore>(),
        ));
    gh.factory<_i8.NoteWatcherBloc>(
        () => _i8.NoteWatcherBloc(gh<_i7.NoteRepo>()));
    gh.lazySingleton<_i9.SplashRepo>(
      () => _i9.SplashRepoImpl(gh<_i3.FirebaseAuth>()),
      registerFor: {_dev},
    );
    gh.factory<_i10.ThemeCubit>(
      () => _i10.ThemeCubit(),
      registerFor: {_dev},
    );
    gh.lazySingleton<_i11.AuthRepo>(
      () => _i11.AuthRepoImpl(
        gh<_i3.FirebaseAuth>(),
        gh<_i6.GoogleSignIn>(),
      ),
      registerFor: {_dev},
    );
    gh.factory<_i12.NoteActorCubit>(
        () => _i12.NoteActorCubit(gh<_i13.NoteRepo>()));
    gh.factory<_i14.NoteFormCubit>(
        () => _i14.NoteFormCubit(gh<_i13.NoteRepo>()));
    gh.factory<_i15.SplashCubit>(
      () => _i15.SplashCubit(gh<_i9.SplashRepo>()),
      registerFor: {_dev},
    );
    gh.factory<_i16.AuthCubit>(
      () => _i16.AuthCubit(gh<_i11.AuthRepo>()),
      registerFor: {_dev},
    );
    return this;
  }
}

class _$ModuleInjection extends _i17.ModuleInjection {}
