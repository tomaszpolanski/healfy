import 'package:flutter/material.dart';
import 'package:healfy/features/timeline/timeline_model.dart';

const completeIconKey = Key('complete-icon');

class TimelineTask extends StatelessWidget {
  const TimelineTask(
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
      margin: const EdgeInsets.only(left: 30, top: 8, bottom: 8, right: 10),
      constraints: const BoxConstraints(
        minHeight: 120,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border.all(
          color: color,
          width: 4,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            data.text,
            style: Theme.of(context).textTheme.headline6,
          ),
          Container(
            color: color,
            child: Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: () => onDone(!data.completed),
                icon: Icon(
                  data.completed ? Icons.close : Icons.done,
                  key: completeIconKey,
                  color: data.completed ? Colors.black : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
