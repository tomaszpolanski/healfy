import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healfy/features/timeline/timeline_element.dart';
import 'package:healfy/features/timeline/timeline_model.dart';

void main() {
  group('completed', () {
    testWidgets('can be undone', (WidgetTester tester) async {
      bool isDone;
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Material(
            child: TimelineElement(
              const TimelineData(TimelineType.wake_up, completed: true),
              color: Colors.white,
              onDone: (done) {
                isDone = done;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(isDone, isFalse);
    });

    testWidgets('check mark is white when not completed',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Material(
            child: TimelineElement(
              const TimelineData(TimelineType.wake_up, completed: true),
              color: Colors.white,
              onDone: (done) {},
            ),
          ),
        ),
      );

      final Icon icon = tester.firstWidget(find.byKey(completeIconKey));

      expect(icon.color, Colors.green);
    });
  });

  group('not completed', () {
    testWidgets('can be completed', (WidgetTester tester) async {
      var isDone = false;
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Material(
            child: TimelineElement(
              const TimelineData(TimelineType.wake_up),
              color: Colors.white,
              onDone: (done) {
                isDone = done;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(isDone, isTrue);
    });

    testWidgets('check mark is white when not completed',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Material(
            child: TimelineElement(
              // ignore: avoid_redundant_argument_values
              const TimelineData(TimelineType.wake_up, completed: false),
              color: Colors.white,
              onDone: (done) {},
            ),
          ),
        ),
      );

      final Icon icon = tester.firstWidget(find.byKey(completeIconKey));

      expect(icon.color, Colors.white);
    });
  });
}