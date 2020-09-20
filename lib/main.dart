import 'package:flutter/material.dart';
import 'package:healfy/features/timeline/timeline_page.dart';

void main() {
  runApp(const HealfyApp());
}

class HealfyApp extends StatelessWidget {
  const HealfyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healfy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const TimelinePage(mockData),
    );
  }
}
