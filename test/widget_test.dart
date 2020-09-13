import 'package:flutter_test/flutter_test.dart';
import 'package:healfy/features/timeline/timeline_page.dart';
import 'package:healfy/main.dart';

void main() {
  testWidgets('Timeline is displayed', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(TimelinePage), findsOneWidget);
  });
}
