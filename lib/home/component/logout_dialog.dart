import 'package:flutter/material.dart';
import 'package:notes/l10n/l10n.dart';

class LogoutDalog extends StatelessWidget {
  const LogoutDalog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return AlertDialog(
      title: Text(l10n.logout),
      content: Text(l10n.areYouSureLogout),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(colorScheme.error),
            foregroundColor: MaterialStatePropertyAll(colorScheme.onError),
          ),
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(l10n.logout),
        ),
      ],
    );
  }
}
