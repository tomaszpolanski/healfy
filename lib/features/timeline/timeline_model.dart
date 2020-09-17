import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum TimelineType { exercise, wake_up, water, food }

class TimelineData extends Equatable {
  const TimelineData(
    this.type, {
    this.completed = false,
    @required this.text,
  });

  final TimelineType type;
  final bool completed;
  final String text;

  TimelineData copyWith({
    bool completed,
    String text,
  }) {
    return TimelineData(
      type,
      completed: completed ?? this.completed,
      text: text ?? this.text,
    );
  }

  @override
  List<Object> get props => [type, completed, text];
}

extension TimelineTypeEx on TimelineType {
  IconData toIcon() {
    switch (this) {
      case TimelineType.exercise:
        return Icons.accessibility;
      case TimelineType.wake_up:
        return Icons.alarm;
      case TimelineType.water:
        return Icons.free_breakfast;
      case TimelineType.food:
        return Icons.fastfood;
    }
    throw Exception('Type not handled');
  }
}
