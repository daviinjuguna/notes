import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart' show optionOf;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/components/components.dart';
import 'package:notes/di/di.dart';
import 'package:notes/home/widgets/note_body.dart';
import 'package:notes/home/widgets/note_color.dart';
import 'package:notes/home/widgets/todo_list.dart';
import 'package:notes/l10n/l10n.dart';
import 'package:notes/notes/notes.dart';
import 'package:notes/routes/app_router.dart';

@RoutePage()
class HomeDetailsPage extends StatefulWidget {
  const HomeDetailsPage({
    super.key,
    @PathParam('id') this.noteId = 'create',
  });
  final String noteId;

  @override
  State<HomeDetailsPage> createState() => _HomeDetailsPageState();
}

class _HomeDetailsPageState extends State<HomeDetailsPage> {
  String get _noteId => widget.noteId;
  NoteWatcherBloc get _noteWatcherBloc => context.read<NoteWatcherBloc>();
  AppLocalizations get _ln10 => AppLocalizations.of(context);

  late NoteFormCubit _noteFormCubit;

  NoteItem? get _editedNote => _noteWatcherBloc.state.notes
      .singleWhereOrNull((e) => e.id.value == _noteId);

  @override
  void initState() {
    super.initState();
    _noteFormCubit = getIt<NoteFormCubit>()..initialized(optionOf(_editedNote));
  }

  @override
  void dispose() {
    _noteFormCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _noteFormCubit,
      child: MultiBlocListener(
        listeners: [
          BlocListener<NoteFormCubit, NoteFormState>(
            listenWhen: (previous, current) =>
                previous.saveFailureOrSuccessOption !=
                current.saveFailureOrSuccessOption,
            listener: (context, state) {
              state.saveFailureOrSuccessOption.fold(
                () => null,
                (either) {
                  either.fold(
                    (error) {
                      SnackbarWidget.error(error, context);
                    },
                    (_) => context.router.popUntil(
                      (route) => route.settings.name == HomeListRoute.name,
                    ),
                  );
                },
              );
            },
          ),
          BlocListener<NoteFormCubit, NoteFormState>(
            listenWhen: (previous, current) =>
                previous.isSaving != current.isSaving,
            listener: (context, state) {
              if (state.isSaving) {
                SnackbarWidget.loading(context);
              } else {
                SnackbarWidget.hide(context);
              }
            },
          )
        ],
        child: Scaffold(
          appBar: AppBar(
            title: BlocBuilder<NoteFormCubit, NoteFormState>(
              buildWhen: (previous, current) =>
                  previous.isEditing != current.isEditing,
              builder: (context, state) {
                final isEdit = state.isEditing;
                return Text(
                  isEdit ? _ln10.editNote : _ln10.addNote,
                );
              },
            ),
            actions: [
              IconButton(
                onPressed: () {
                  _noteFormCubit.onSaved();
                },
                icon: const Icon(Icons.check),
              )
            ],
          ),
          body: BlocBuilder<NoteFormCubit, NoteFormState>(
            buildWhen: (previous, current) =>
                previous.showErrorMessages != current.showErrorMessages,
            builder: (context, state) {
              return Form(
                autovalidateMode: state.showErrorMessages
                    ? AutovalidateMode.always
                    : AutovalidateMode.onUserInteraction,
                child: const CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(child: NoteBody()),
                    SliverToBoxAdapter(child: NoteColor()),
                    SliverToBoxAdapter(child: TodoList())
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
