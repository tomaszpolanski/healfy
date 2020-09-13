import 'package:flutter/material.dart';

enum TimelineType { exercise, wake_up, water, food }

class TimelineData {
  const TimelineData(this.type);

  final TimelineType type;
}

extension TimelineTypeEx on TimelineType {
  IconData toIcon() {
    switch (this) {
      case TimelineType.exercise:
        return Icons.sports_handball;
      case TimelineType.wake_up:
        return Icons.alarm;
      case TimelineType.water:
        return Icons.emoji_food_beverage;
      case TimelineType.food:
        return Icons.fastfood_sharp;
    }
    throw Exception('Type not handled');
  }
}
