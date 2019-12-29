// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:notification_notes/main.dart';

void main() {
  testWidgets('Check if title exists', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('Notification Notes'), findsOneWidget);
    expect(find.text('Notification notes'), findsNothing);
  });

  testWidgets("Dialogbox shows when clicking add icon", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text("Title"), findsOneWidget);
    expect(find.text("Description"), findsOneWidget);
    expect(find.text("Save"), findsOneWidget);


  });
}
