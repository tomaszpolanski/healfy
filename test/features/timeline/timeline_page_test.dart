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
            TimelineData(
              TimelineType.wake_up,
              text: 'Lorem Ipsum Donor',
            ),
          ],
        ),
      ),
    );

    expect(find.byType(TimelineTask), findsOneWidget);
  });

  testWidgets('can be completed', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: TimelinePage(
          [
            TimelineData(
              TimelineType.wake_up,
              // ignore: avoid_redundant_argument_values
              completed: false,
              text: 'Lorem Ipsum Donor',
            ),
          ],
        ),
      ),
    );

    await tester.tap(find.byKey(completeIconKey));
    await tester.pumpAndSettle();
    final TimelineTask element = tester.firstWidget(
      find.byType(TimelineTask),
    );

    expect(element.data.completed, isTrue);
  });
}
