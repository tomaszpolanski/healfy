import 'package:flutter/material.dart';
import 'package:healfy/features/timeline/timeline_element.dart';
import 'package:healfy/features/timeline/timeline_model.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimelinePage extends StatelessWidget {
  const TimelinePage(this.data, {Key key}) : super(key: key);
  final List<TimelineData> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _Content(data),
    );
  }
}

class _Content extends StatefulWidget {
  const _Content(
    this.data, {
    Key key,
  }) : super(key: key);

  final List<TimelineData> data;

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  List<TimelineData> _data;

  @override
  void initState() {
    super.initState();
    _data = List.from(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(height: MediaQuery.of(context).padding.top),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[
              Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ..._data.mapIndexed(
                      (index, d) {
                        final color = index % 4 == 0
                            ? Colors.amberAccent
                            : index % 3 == 0
                                ? Colors.lightBlue
                                // ignore: use_is_even_rather_than_modulo
                                : index % 2 == 0
                                    ? Colors.redAccent
                                    : Colors.greenAccent;
                        final prevColor = (index - 1) % 4 == 0
                            ? Colors.amberAccent
                            : (index - 1) % 3 == 0
                                ? Colors.lightBlue
                                // ignore: use_is_even_rather_than_modulo
                                : (index - 1) % 2 == 0
                                    ? Colors.redAccent
                                    : Colors.greenAccent;
                        return TimelineElement(
                          d,
                          color: color,
                          previousColor: prevColor,
                          isFirst: index == 0,
                          isLast: index == _data.length - 1,
                          child: TimelineTask(
                            d,
                            color: color,
                            onDone: (bool value) {
                              setState(() {
                                _data = _data
                                    .map((data) => data == d
                                        ? data.copyWith(completed: value)
                                        : data)
                                    .toList(growable: false);
                              });
                            },
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TimelineElement extends StatelessWidget {
  const TimelineElement(
    this.data, {
    Key key,
    @required this.isFirst,
    @required this.isLast,
    @required this.color,
    @required this.previousColor,
    @required this.child,
  }) : super(key: key);

  final TimelineData data;
  final bool isFirst;
  final bool isLast;
  final Color previousColor;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.1,
      isFirst: isFirst,
      isLast: isLast,
      afterLineStyle: LineStyle(color: color),
      beforeLineStyle: previousColor != null
          ? LineStyle(
              color: previousColor,
            )
          : null,
      indicatorStyle: IndicatorStyle(
        width: 40,
        height: 40,
        color: color,
        indicator: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Icon(
            data.type.toIcon(),
            color: Colors.white,
          ),
        ),
      ),
      endChild: child,
    );
  }
}

const mockData = [
  TimelineData(TimelineType.wake_up, text: 'Wake up!'),
  TimelineData(TimelineType.water, text: 'Grab a glass of water'),
  TimelineData(TimelineType.exercise, text: 'Lift some heavy things!'),
  TimelineData(TimelineType.food, text: 'Food time!'),
  TimelineData(TimelineType.water, text: 'Grab a glass of water'),
  TimelineData(TimelineType.exercise, text: 'Food time!'),
  TimelineData(TimelineType.food, text: 'Food time!'),
  TimelineData(TimelineType.water, text: 'Grab a glass of water'),
  TimelineData(TimelineType.exercise, text: 'Lift some heavy things!'),
  TimelineData(TimelineType.water, text: 'Grab a glass of vino Valeria!'),
];

extension IterableEx<T> on Iterable<T> {
  Iterable<T> joinEx(T separator) sync* {
    final iterator = this.iterator;
    if (iterator.moveNext()) {
      yield iterator.current;
      while (iterator.moveNext()) {
        yield separator;
        yield iterator.current;
      }
    }
  }

  Iterable<R> mapIndexed<R>(R Function(int index, T) mapper) sync* {
    int i = 0;
    for (final value in this) {
      yield mapper(i++, value);
    }
  }

  List<T> sorted([int Function(T a, T b) compare]) {
    return List.of(this)..sort(compare);
  }
}
