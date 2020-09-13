import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healfy/features/timeline/timeline_element.dart';
import 'package:healfy/features/timeline/timeline_model.dart';
import 'package:healfy/features/timeline/timeline_page.dart';

void main() {
  testWidgets('displays item', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: TimelinePage(
          [
            TimelineData(TimelineType.wake_up),
          ],
        ),
      ),
    );

    expect(find.byType(TimelineElement), findsOneWidget);
  });

  testWidgets('can be completed', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: TimelinePage(
          [
            // ignore: avoid_redundant_argument_values
            TimelineData(TimelineType.wake_up, completed: false),
          ],
        ),
      ),
    );

    await tester.tap(find.byKey(completeIconKey));
    await tester.pumpAndSettle();
    final TimelineElement element = tester.firstWidget(
      find.byType(TimelineElement),
    );

    expect(element.data.completed, isTrue);
  });
}
