import 'package:flutter/material.dart';
import 'package:healfy/features/timeline/timeline_model.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimelinePage extends StatelessWidget {
  const TimelinePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _Content(_mockData),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content(
    this.data, {
    Key key,
  }) : super(key: key);

  final List<TimelineData> data;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[
              Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ...data.mapIndexed(
                      (index, d) {
                        return TimelineTile(
                          alignment: TimelineAlign.manual,
                          lineX: 0.1,
                          isFirst: index == 0,
                          isLast: index == data.length - 1,
                          indicatorStyle: IndicatorStyle(
                            width: 40,
                            height: 40,
                            color: Colors.blue,
                            indicator: Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: Icon(
                                d.type.toIcon(),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          rightChild: Container(
                            constraints: const BoxConstraints(
                              minHeight: 120,
                            ),
                            color: index % 4 == 0
                                ? Colors.amberAccent
                                : index % 3 == 0
                                    ? Colors.lightBlue
                                    // ignore: use_is_even_rather_than_modulo
                                    : index % 2 == 0
                                        ? Colors.redAccent
                                        : Colors.greenAccent,
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

const _mockData = [
  TimelineData(TimelineType.wake_up),
  TimelineData(TimelineType.water),
  TimelineData(TimelineType.exercise),
  TimelineData(TimelineType.food),
  TimelineData(TimelineType.water),
  TimelineData(TimelineType.exercise),
  TimelineData(TimelineType.food),
  TimelineData(TimelineType.water),
  TimelineData(TimelineType.exercise),
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