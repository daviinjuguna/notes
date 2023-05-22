part of 'note_watcher_bloc.dart';

@immutable
class NoteWatcherState {
  const NoteWatcherState({
    this.status = NoteWatcherStatus.initial,
    this.notes = const [],
    this.errorCode = '',
  });
  final NoteWatcherStatus status;
  final List<NoteItem> notes;
  final String errorCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NoteWatcherState &&
        other.status == status &&
        listEquals(other.notes, notes) &&
        other.errorCode == errorCode;
  }

  @override
  int get hashCode => status.hashCode ^ notes.hashCode ^ errorCode.hashCode;

  NoteWatcherState copyWith({
    NoteWatcherStatus? status,
    List<NoteItem>? notes,
    String? errorCode,
  }) {
    return NoteWatcherState(
      status: status ?? this.status,
      notes: notes ?? this.notes,
      errorCode: errorCode ?? this.errorCode,
    );
  }
}

enum NoteWatcherStatus {
  initial,
  loading,
  success,
  failure,
}
