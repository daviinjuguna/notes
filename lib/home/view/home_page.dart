import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/di/injection.dart';
import 'package:notes/notes/note_objects/note_body.dart';
import 'package:notes/notes/note_objects/note_color.dart';
import 'package:notes/notes/notes.dart';
import 'package:notes/objects/unique_id/unique_id.dart';
import 'package:notes/splash/splash.dart';
import 'package:notes/todo/entity/todo_item.dart';
import 'package:notes/todo/todo_objects/todo_title.dart';
import 'package:notes/utils/utils.dart';

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

    getIt<NoteRepo>().create(
      NoteItem(
        id: UniqueId(),
        body: const NoteBody.dirty('The first note'),
        color: NoteColor.dirty(AppColor.noteColors.first),
        todos: [
          TodoItem(
            id: UniqueId(),
            title: const TodoTitle.dirty('First todo'),
            done: false,
          )
        ],
      ),
    );
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
              onPressed: () {
                _splashCubit.logout();
              },
            ),
          ),
        ),
      ),
    );
  }
}
