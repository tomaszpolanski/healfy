import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healfy/features/timeline/timeline_model.dart';

void main() {
  group('icons', () {
    <TimelineType, IconData>{
      TimelineType.water: Icons.emoji_food_beverage,
      TimelineType.food: Icons.fastfood_sharp,
      TimelineType.exercise: Icons.sports_handball,
      TimelineType.wake_up: Icons.alarm,
    }.forEach((type, icon) {
      test('shows icon for $type', () {
        final tested = type.toIcon();

        expect(tested, icon);
      });
    });
    group('all types have icons', () {
      // ignore: avoid_function_literals_in_foreach_calls
      TimelineType.values.forEach((type) {
        test('$type', () {
          final tested = type.toIcon();

          expect(tested, isNotNull);
        });
      });
    });
  });
}
