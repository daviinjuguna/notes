import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/notes/entity/note_item.dart';
import 'package:notes/notes/repo/note_repo.dart';

part 'note_watcher_event.dart';
part 'note_watcher_state.dart';

@injectable
class NoteWatcherBloc extends Bloc<NoteWatcherEvent, NoteWatcherState> {
  NoteWatcherBloc(this._noteRepo) : super(const NoteWatcherState()) {
    on<AllNoteWatcherEvent>((event, emit) async {
      emit(state.copyWith(status: NoteWatcherStatus.loadInProgress));
      await _noteStreamSubscription?.cancel();
      _noteStreamSubscription = _noteRepo.watchAll().listen(
            (failureOrNotes) => add(_ReceivedNoteWatcherEvent(failureOrNotes)),
          );
    });
    on<UncompletedNoteWatcherEvent>((event, emit) async {
      emit(state.copyWith(status: NoteWatcherStatus.loadInProgress));
      await _noteStreamSubscription?.cancel();
      _noteStreamSubscription = _noteRepo.watchUncompleted().listen(
            (failureOrNotes) => add(_ReceivedNoteWatcherEvent(failureOrNotes)),
          );
    });
    on<_ReceivedNoteWatcherEvent>((event, emit) {
      final failureOrNotes = event.failureOrNotes;
      emit(
        failureOrNotes.fold(
          (error) => state.copyWith(
            status: NoteWatcherStatus.loadFailure,
            errorCode: error,
          ),
          (notes) => state.copyWith(
            status: NoteWatcherStatus.loadSuccess,
            notes: notes,
          ),
        ),
      );
    });
  }

  StreamSubscription<Either<String, List<NoteItem>>>? _noteStreamSubscription;
  final NoteRepo _noteRepo;

  @override
  Future<void> close() async {
    await _noteStreamSubscription?.cancel();
    return super.close();
  }
}
