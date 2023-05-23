import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/home/component/logout_dialog.dart';
import 'package:notes/home/widgets/error_note_card.dart';
import 'package:notes/home/widgets/icon_check.dart';
import 'package:notes/home/widgets/note_card.dart';
import 'package:notes/l10n/l10n.dart';
import 'package:notes/notes/notes.dart';
import 'package:notes/routes/app_router.dart';
import 'package:notes/splash/splash.dart';

@RoutePage(name: 'HomeListRoute')
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SplashCubit get _splashCubit => context.read<SplashCubit>();
  NoteWatcherBloc get _noteWatcherBloc => context.read<NoteWatcherBloc>();
  AppLocalizations get _ln10 => AppLocalizations.of(context);

  @override
  void initState() {
    super.initState();
    _noteWatcherBloc.add(AllNoteWatcherEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.navigateTo(HomeDetailsRoute());
          },
          child: const Icon(Icons.add),
        ),
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
          actions: [
            IconCheck(
              onCheck: ({required bool value}) {
                print(value);
              },
            )
          ],
        ),
        body: BlocBuilder<NoteWatcherBloc, NoteWatcherState>(
          builder: (context, state) {
            switch (state.status) {
              case NoteWatcherStatus.initial:
                return Container();
              case NoteWatcherStatus.loading:
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              case NoteWatcherStatus.success:
                return ListView.builder(
                  itemCount: state.notes.length,
                  itemBuilder: (_, index) {
                    final note = state.notes.elementAt(index);
                    if (note.failedValidation) return ErrorNoteCard(note: note);
                    return NoteCard(note: note);
                  },
                );
              case NoteWatcherStatus.failure:
                //error
                return FilledButton.tonalIcon(
                  onPressed: () {
                    _noteWatcherBloc.add(AllNoteWatcherEvent());
                  },
                  label: Text(_ln10.retry),
                  icon: const Icon(Icons.refresh),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.errorContainer,
                    ),
                    foregroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.onErrorContainer,
                    ),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
