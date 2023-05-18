import 'dart:ui';

import 'package:formz/formz.dart';

enum NoteColorValidationError { invalid }

class NoteColor extends FormzInput<Color?, NoteColorValidationError> {
  const NoteColor.pure() : super.pure(null);
  const NoteColor.dirty([super.value]) : super.dirty();

  @override
  NoteColorValidationError? validator(Color? value) {
    return value == null ? NoteColorValidationError.invalid : null;
  }
}
