part of 'note_form_cubit.dart';

@immutable
class NoteFormState {
  const NoteFormState._({
    required this.note,
    required this.showErrorMessages,
    required this.isEditing,
    required this.isSaving,
    required this.saveFailureOrSuccessOption,
  });

  factory NoteFormState.initial() => NoteFormState._(
        note: NoteItem.empty(),
        showErrorMessages: false,
        isEditing: false,
        isSaving: false,
        saveFailureOrSuccessOption: none(),
      );

  final NoteItem note;
  final bool showErrorMessages;
  final bool isEditing;
  final bool isSaving;
  final Option<Either<String, Unit>> saveFailureOrSuccessOption;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NoteFormState &&
        other.note == note &&
        other.showErrorMessages == showErrorMessages &&
        other.isEditing == isEditing &&
        other.isSaving == isSaving &&
        other.saveFailureOrSuccessOption == saveFailureOrSuccessOption;
  }

  @override
  int get hashCode {
    return note.hashCode ^
        showErrorMessages.hashCode ^
        isEditing.hashCode ^
        isSaving.hashCode ^
        saveFailureOrSuccessOption.hashCode;
  }

  NoteFormState copyWith({
    NoteItem? note,
    bool? showErrorMessages,
    bool? isEditing,
    bool? isSaving,
    Option<Either<String, Unit>>? saveFailureOrSuccessOption,
  }) {
    return NoteFormState._(
      note: note ?? this.note,
      showErrorMessages: showErrorMessages ?? this.showErrorMessages,
      isEditing: isEditing ?? this.isEditing,
      isSaving: isSaving ?? this.isSaving,
      saveFailureOrSuccessOption:
          saveFailureOrSuccessOption ?? this.saveFailureOrSuccessOption,
    );
  }
}
