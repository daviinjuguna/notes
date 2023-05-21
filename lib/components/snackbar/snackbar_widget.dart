import 'package:flutter/material.dart';
import 'package:notes/l10n/l10n.dart';

class SnackbarWidget {
  static void hide(BuildContext context) =>
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

  static ScaffoldMessengerState info(
    String info,
    BuildContext context, [
    String? header,
  ]) =>
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).primaryColor,
            behavior: SnackBarBehavior.fixed,
            duration: const Duration(seconds: 5),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (header != null)
                  Text(
                    header,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                Text(
                  info,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )
              ],
            ),
          ),
        );

  static ScaffoldMessengerState loading(
    BuildContext context, [
    String? loading,
    Duration duration = const Duration(seconds: 60),
  ]) =>
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.fixed,
            duration: duration,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            content: Row(
              children: [
                Text(
                  loading ?? AppLocalizations.of(context).loading,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                const CircularProgressIndicator()
              ],
            ),
          ),
        );

  static ScaffoldMessengerState error(
    String error,
    BuildContext context, [
    String? header,
  ]) =>
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.error,
            behavior: SnackBarBehavior.fixed,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  header ?? AppLocalizations.of(context).ohSnap,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onError,
                  ),
                ),
                Text(
                  error,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onError),
                )
              ],
            ),
          ),
        );
}
