import 'package:formz/formz.dart';

enum NoteBodyValidationErrors { empty, tooLong }

class NoteBody extends FormzInput<String, NoteBodyValidationErrors> {
  const NoteBody.pure() : super.pure('');
  const NoteBody.dirty([super.value = '']) : super.dirty();

  @override
  NoteBodyValidationErrors? validator(String value) {
    if (value.isEmpty) {
      return NoteBodyValidationErrors.empty;
    } else if (value.length > 1000) {
      return NoteBodyValidationErrors.tooLong;
    } else {
      return null;
    }
  }
}
