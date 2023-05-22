import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/di/injection.dart';
import 'package:notes/home/component/logout_dialog.dart';
import 'package:notes/notes/notes.dart';
import 'package:notes/splash/splash.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SplashCubit get _splashCubit => context.read<SplashCubit>();

  late final NoteWatcherBloc _noteWatcherBloc;
  late final NoteActorCubit _noteActorCubit;

  @override
  void initState() {
    super.initState();
    _noteWatcherBloc = getIt<NoteWatcherBloc>()..add(AllNoteWatcherEvent());
    _noteActorCubit = getIt<NoteActorCubit>();
  }

  @override
  void dispose() {
    _noteWatcherBloc.close();
    _noteActorCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _noteWatcherBloc),
        BlocProvider(create: (context) => _noteActorCubit),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<NoteActorCubit, NoteActorState>(
            listener: (context, state) {
              switch (state.status) {
                case NoteActorStatus.initial:
                  break;
                case NoteActorStatus.loading:
                  break;
                case NoteActorStatus.success:
                  break;
                case NoteActorStatus.failure:
                  break;
              }
            },
          )
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Notes'),
            leading: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                final logout = await showDialog<bool>(
                  context: context,
                  builder: (context) => const LogoutDalog(),
                );
                if (logout ?? false) {
                  await _splashCubit.logout();
                }
              },
            ),
            actions: [],
          ),
        ),
      ),
    );
  }
}
