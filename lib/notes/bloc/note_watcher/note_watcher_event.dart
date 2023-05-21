part of 'note_watcher_bloc.dart';

@immutable
abstract class NoteWatcherEvent {}

class AllNoteWatcherEvent extends NoteWatcherEvent {}

class UncompletedNoteWatcherEvent extends NoteWatcherEvent {}

class _ReceivedNoteWatcherEvent extends NoteWatcherEvent {
  _ReceivedNoteWatcherEvent(this.failureOrNotes);

  final Either<String, List<NoteItem>> failureOrNotes;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _ReceivedNoteWatcherEvent &&
        other.failureOrNotes == failureOrNotes;
  }

  @override
  int get hashCode => failureOrNotes.hashCode;
}
