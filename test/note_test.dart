import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notification_notes/main.dart';

void main() {
  testWidgets('Check if title exists', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('Notification notes'), findsOneWidget);
    expect(find.text('Notification Notes'), findsNothing);
  });

  testWidgets("Dialogbox shows when clicking add icon",
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text("Title"), findsOneWidget);
    expect(find.text("Description"), findsOneWidget);
    expect(find.text("Save"), findsOneWidget);
    expect(find.widgetWithText(TextFormField, "Title"), findsOneWidget);
    expect(find.widgetWithText(TextFormField, "Description"), findsOneWidget);
    expect(find.byType(MaterialButton), findsOneWidget);
  });

  testWidgets("Create one note", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    await createNote(tester, "aaa", "bbbb");

    expect(find.byType(TextFormField), findsNothing);
    expect(find.byType(MaterialButton), findsNothing);

    expect(find.byType(ListTile), findsOneWidget);
  });

  testWidgets("Create 10 notes", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    for (var i = 0; i < 10; i++) await createNote(tester, "aaa$i", "bbb$i");

    expect(find.byType(TextFormField), findsNothing);
    expect(find.byType(MaterialButton), findsNothing);

    expect(find.byType(ListTile), findsNWidgets(10));
  });
}

createNote(WidgetTester tester, String title, String description) async {
  await tester.tap(find.byIcon(Icons.add));
  await tester.pump();

  expect(find.byType(TextFormField), findsNWidgets(2));
  await tester.enterText(find.widgetWithText(TextFormField, "Title"), title);
  await tester.enterText(
      find.widgetWithText(TextFormField, "Description"), description);

  expect(find.text(title), findsOneWidget);
  expect(find.text(description), findsOneWidget);

  await tester.tap(find.byType(MaterialButton));
  await tester.pump();
}
