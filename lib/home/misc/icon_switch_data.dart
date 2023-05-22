import 'package:flutter/material.dart';

@immutable
class IconSwitchData {
  const IconSwitchData({
    required this.toggle,
    required this.icon,
  });
  final bool toggle;
  final Widget icon;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IconSwitchData &&
        other.toggle == toggle &&
        other.icon == icon;
  }

  @override
  int get hashCode => toggle.hashCode ^ icon.hashCode;
}
