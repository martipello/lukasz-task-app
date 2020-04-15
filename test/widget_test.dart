import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tasks/main.dart';

void main() {
  testWidgets('Add a new Task', (WidgetTester tester) async {
    // Finders
    final list = find.byType(ListView);
    final addButton = find.byIcon(Icons.note_add);
    final saveButton = find.text('Save');

    // Build the app.
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    // Verify 1. task displayed
    final task1 = find.descendant(
      of: list,
      matching: find.text('Change the FAB icon'),
    );
    expect(task1, findsOneWidget);

    // Tap the '+' button if it exists
    expect(addButton, findsOneWidget);
    await tester.tap(addButton);

    // Wait for the Dialog to show
    await tester.pump();
    await tester.idle();

    // Enter a new task title
    final formField = find.byType(TextFormField);
    expect(formField, findsOneWidget);
    await tester.enterText(formField, 'Test the app');

    // Save the task
    await tester.tap(saveButton);

    // Wait for the Dialog to close
    await tester.pump();
    await tester.idle();

    // Verify the new task has been added
    final task2 = find.descendant(
      of: list,
      matching: find.text('Test the app'),
    );
    expect(task2, findsOneWidget);
  });
}
