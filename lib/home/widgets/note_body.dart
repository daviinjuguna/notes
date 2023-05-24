import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/l10n/l10n.dart';
import 'package:notes/notes/notes.dart';

class NoteBody extends StatefulWidget {
  const NoteBody({super.key});

  @override
  State<NoteBody> createState() => _NoteBodyState();
}

class _NoteBodyState extends State<NoteBody> {
  NoteFormCubit get _noteFormCubit => context.read<NoteFormCubit>();
  AppLocalizations get _ln10 => AppLocalizations.of(context);
  late final TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: _noteFormCubit.state.note.body.value,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteFormCubit, NoteFormState>(
      listenWhen: (previous, current) =>
          previous.isEditing != current.isEditing,
      listener: (context, state) {
        _controller.text = state.note.body.value;
      },
      buildWhen: (previous, current) =>
          previous.note.body != current.note.body ||
          previous.note.color != current.note.color,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              fillColor: state.note.color.value,
              labelText: _ln10.note,
            ),
            maxLength: 2000,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            maxLines: null,
            minLines: 5,
            onChanged: (value) => _noteFormCubit.bodyChanged(value),
            validator: (value) {
              if (_noteFormCubit.state.note.body.isValid) return null;
              return _ln10.invalidNotes;
            },
          ),
        );
      },
    );
  }
}
