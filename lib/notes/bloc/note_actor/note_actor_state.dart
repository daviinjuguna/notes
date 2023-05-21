part of 'note_actor_cubit.dart';

@immutable
class NoteActorState {
  const NoteActorState({
    this.status = NoteActorStatus.initial,
    this.errorCode = '',
  });

  final NoteActorStatus status;
  final String errorCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NoteActorState &&
        other.status == status &&
        other.errorCode == errorCode;
  }

  @override
  int get hashCode => status.hashCode ^ errorCode.hashCode;

  NoteActorState copyWith({
    NoteActorStatus? status,
    String? errorCode,
  }) {
    return NoteActorState(
      status: status ?? this.status,
      errorCode: errorCode ?? this.errorCode,
    );
  }
}

enum NoteActorStatus { initial, loading, success, failure }
