import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/notes/note_objects/note_body.dart';
import 'package:notes/notes/note_objects/note_color.dart';
import 'package:notes/notes/notes.dart';
import 'package:notes/todo/todo.dart';

part 'note_form_state.dart';

@injectable
class NoteFormCubit extends Cubit<NoteFormState> {
  NoteFormCubit(this._noteRepo) : super(NoteFormState.initial());

  final NoteRepo _noteRepo;

  Future<void> initialized(Option<NoteItem> initialNoteOption) async {
    emit(
      state.copyWith(
        note: initialNoteOption.fold(
          NoteItem.empty,
          (initialNote) => initialNote,
        ),
        isEditing: initialNoteOption.isSome(),
      ),
    );
  }

  Future<void> bodyChanged(String bodyString) async {
    emit(
      state.copyWith(
        note: state.note.copyWith(
          body: NoteBody.dirty(bodyString),
        ),
        saveFailureOrSuccessOption: none(),
      ),
    );
  }

  Future<void> colorChanged(Color color) async {
    emit(
      state.copyWith(
        note: state.note.copyWith(
          color: NoteColor.dirty(color),
        ),
        saveFailureOrSuccessOption: none(),
      ),
    );
  }

  Future<void> todosChanged(List<TodoItem> todos) async {
    emit(
      state.copyWith(
        note: state.note.copyWith(
          todos: todos,
        ),
        saveFailureOrSuccessOption: none(),
      ),
    );
  }

  Future<void> onSaved() async {
    Either<String, Unit> failureOrSuccess;
    emit(state.copyWith(isSaving: true, saveFailureOrSuccessOption: none()));
    if (!state.note.failedValidation) {
      failureOrSuccess = state.isEditing
          ? await _noteRepo.update(state.note)
          : await _noteRepo.create(state.note);
    } else {
      failureOrSuccess = left(state.note.validationError);
    }

    emit(
      state.copyWith(
        isSaving: false,
        showErrorMessages: true,
        saveFailureOrSuccessOption: optionOf(failureOrSuccess),
      ),
    );
  }
}
