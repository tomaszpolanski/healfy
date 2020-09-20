import 'package:flare_flutter/flare_actor.dart';
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
    return Card(
      elevation: 10,
      margin: const EdgeInsets.only(left: 30, top: 8, bottom: 8, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 80,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: TimelineContent(data),
            ),
          ),
          Material(
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

class TimelineContent extends StatelessWidget {
  const TimelineContent(this.data, {Key key}) : super(key: key);

  final TimelineData data;

  @override
  Widget build(BuildContext context) {
    return data.type != TimelineType.wake_up
        ? Text(
            data.text,
            style: Theme.of(context).textTheme.headline6,
          )
        : const SizedBox(
            height: 100,
            width: 100,
            child: Rive('alarm', animation: 'play', repeat: 1),
          );
  }
}

class Rive extends StatefulWidget {
  const Rive(
    this.asset, {
    @required this.animation,
    this.repeat = 0,
    Key key,
  }) : super(key: key);

  final String asset;
  final String animation;
  final int repeat;

  @override
  _RiveState createState() => _RiveState();
}

class _RiveState extends State<Rive> {
  String _animationName;
  int repeatCount = 0;

  @override
  void initState() {
    _animationName = widget.animation;
    super.initState();
  }

  Future<void> _repeat() async {
    setState(() {
      _animationName = 'idle';
    });
    await Future<void>.delayed(const Duration(seconds: 1));
    setState(() {
      _animationName = widget.animation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _repeat();
      },
      child: FlareActor(
        'assets/${widget.asset}.flr',
        animation: _animationName,
        callback: (_) async {
          if (repeatCount++ < widget.repeat) {
            await _repeat();
          }
        },
      ),
    );
  }
}
