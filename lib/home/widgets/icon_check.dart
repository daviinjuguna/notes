import 'package:flutter/material.dart';

class IconCheck extends StatefulWidget {
  const IconCheck({super.key, required this.onCheck});
  final void Function({required bool value}) onCheck;

  @override
  State<IconCheck> createState() => _IconCheckState();
}

class _IconCheckState extends State<IconCheck> {
  void Function({required bool value}) get _onCheck => widget.onCheck;
  late bool _check;
  @override
  void initState() {
    super.initState();
    _check = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          _check = !_check;
        });
        _onCheck(value: _check);
      },
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 100),
        child: _check
            ? const Icon(
                Icons.check_box,
                key: Key('outline'),
              )
            : const Icon(
                Icons.check_box_outline_blank,
                key: Key('indeterminate'),
              ),
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
      ),
    );
  }
}
