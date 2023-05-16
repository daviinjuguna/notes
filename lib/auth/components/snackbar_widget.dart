import 'package:flutter/material.dart';

class SnackBarWidget {
  static void hideSnackbar([
    BuildContext? context,
    GlobalKey<ScaffoldMessengerState>? key,
  ]) {
    if (context != null) {
      return ScaffoldMessenger.maybeOf(context)?.hideCurrentSnackBar();
    }
    if (key != null) return key.currentState?.hideCurrentSnackBar();
  }

  static ScaffoldMessengerState? infoSnackBar(
    String message, {
    BuildContext? context,
    GlobalKey<ScaffoldMessengerState>? key,
    String? header,
  }) {
    assert(context != null || key != null);
    if (context != null) {
      return ScaffoldMessenger.maybeOf(context)
        ?..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
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
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        );
    }
    if (key != null) {
      return key.currentState
        ?..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 5),
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
                if (header != null)
                  Text(
                    header,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        );
    }
    return null;
  }

  static ScaffoldMessengerState? loadingSnackBar([
    BuildContext? context,
    String? title,
    String? message,
    GlobalKey<ScaffoldMessengerState>? key,
    Duration duration = const Duration(seconds: 60),
  ]) {
    assert(context != null || key != null);
    if (context != null) {
      return ScaffoldMessenger.maybeOf(context)
        ?..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            duration: duration,
            behavior: SnackBarBehavior.fixed,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            content: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title?.toUpperCase() ?? 'LOADING',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      message ?? 'Please wait...',
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
                const Spacer(),
                const CircularProgressIndicator()
              ],
            ),
          ),
        );
    }
    if (key != null) {
      return key.currentState
        ?..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 60),
            behavior: SnackBarBehavior.fixed,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            content: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title?.toUpperCase() ?? 'LOADING',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      'Please wait...',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                const Spacer(),
                const CircularProgressIndicator()
              ],
            ),
          ),
        );
    }
    return null;
  }

  static ScaffoldMessengerState? errorSnackBar(
    BuildContext? context,
    String message, {
    String? title,
    GlobalKey<ScaffoldMessengerState>? key,
  }) {
    assert(context != null || key != null);
    if (context != null) {
      return ScaffoldMessenger.maybeOf(context)
        ?..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            // duration: const Duration(seconds: 10),
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
                  title ?? 'Oh Snap!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onError,
                  ),
                ),
                // SizedBox(height: 3),
                Text(
                  message,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onError),
                )
              ],
            ),
          ),
        );
    }
    if (key != null) {
      return key.currentState
        ?..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            // duration: const Duration(seconds: 10),
            backgroundColor: Colors.red,
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
                  title ?? 'Error',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                // SizedBox(height: 3),
                Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        );
    }
    return null;
  }

  static ScaffoldMessengerState? successSnackBar(
    BuildContext? context,
    String message, {
    GlobalKey<ScaffoldMessengerState>? key,
  }) {
    assert(context != null || key != null);
    if (context != null) {
      return ScaffoldMessenger.maybeOf(context)
        ?..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.green,
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
                const Text(
                  'Success',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                // SizedBox(height: 3),
                Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        );
    }
    if (key != null) {
      return key.currentState
        ?..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            // duration: const Duration(seconds: 5),
            backgroundColor: Colors.green,
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
                const Text(
                  'Success',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                // SizedBox(height: 3),
                Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        );
    }
    return null;
  }
}
