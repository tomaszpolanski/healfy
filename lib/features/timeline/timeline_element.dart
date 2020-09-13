import 'package:flutter/material.dart';
import 'package:healfy/features/timeline/timeline_model.dart';

const completeIconKey = Key('complete-icon');

class TimelineElement extends StatelessWidget {
  const TimelineElement(
    this.data, {
    @required this.color,
    @required this.onDone,
    Key key,
  }) : super(key: key);

  final TimelineData data;
  final Color color;
  final ValueChanged<bool> onDone;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 120,
      ),
      color: color,
      child: Align(
        alignment: Alignment.bottomRight,
        child: IconButton(
          onPressed: () => onDone(!data.completed),
          icon: Icon(
            Icons.done,
            key: completeIconKey,
            color: data.completed ? Colors.green : Colors.white,
          ),
        ),
      ),
    );
  }
}
