import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/di/di.dart';
import 'package:notes/notes/bloc/bloc.dart';

@RoutePage(name: 'HomeRoute')
class HomeEmptyRoute extends AutoRouter implements StatefulWidget {
  const HomeEmptyRoute({super.key});

  @override
  Widget Function(BuildContext context, Widget child)? get builder =>
      (context, child) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<NoteWatcherBloc>()),
              BlocProvider(create: (context) => getIt<NoteActorCubit>()),
              BlocProvider(create: (create) => getIt<NoteFormCubit>())
            ],
            child: child,
          );


}
