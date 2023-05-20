import 'package:formz/formz.dart';

enum TodoTitleValidationErrors { empty, tooLong }

class TodoTitle extends FormzInput<String, TodoTitleValidationErrors> {
  const TodoTitle.pure() : super.pure('');
  const TodoTitle.dirty([super.value = '']) : super.dirty();

  @override
  TodoTitleValidationErrors? validator(String value) {
    if (value.isEmpty) {
      return TodoTitleValidationErrors.empty;
    } else if (value.length > 30) {
      return TodoTitleValidationErrors.tooLong;
    } else {
      return null;
    }
  }
}
