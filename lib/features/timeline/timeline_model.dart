import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum TimelineType { exercise, wake_up, water, food }

class TimelineData extends Equatable {
  const TimelineData(
    this.type, {
    this.completed = false,
  });

  final TimelineType type;
  final bool completed;

  TimelineData copyWith({
    bool completed,
  }) {
    return TimelineData(
      type,
      completed: completed ?? this.completed,
    );
  }

  @override
  List<Object> get props => [type, completed];
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
