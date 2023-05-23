import 'package:flutter/material.dart';
import 'package:notes/l10n/l10n.dart';
import 'package:notes/notes/notes.dart';

class ErrorNoteCard extends StatelessWidget {
  const ErrorNoteCard({super.key, required this.note});
  final NoteItem note;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(_validationError(note.validationError, context)),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}

String _validationError(String errorCode, BuildContext context) {
  final ln10 = AppLocalizations.of(context);
  switch (errorCode) {
    default:
      return ln10.invalidNotes;
  }
}
