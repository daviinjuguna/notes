import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStackRouter extends Mock implements StackRouter {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) {
    return pumpWidget(
      StackRouterScope(
        controller: MockStackRouter(),
        stateHash: 0,
        child: widget,
      ),
    );
  }
}
