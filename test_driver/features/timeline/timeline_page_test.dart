import 'dart:convert';

import 'package:fast_flutter_driver/tool.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../../generic/screenshots.dart';
import '../../generic/test_configuration.dart';

void main(List<String> args) {
  FlutterDriver driver;
  Screenshot screenshot;
  final properties = TestProperties(args);

  setUpAll(() async {
    driver = await FlutterDriver.connect(dartVmServiceUrl: properties.vmUrl);
    screenshot = await Screenshot.create(
      driver,
      'timeline',
      enabled: properties.screenshotsEnabled,
    );
  });

  setUpAll(() async {});
  tearDownAll(() async {
    await driver?.close();
  });

  Future<void> restart() {
    return driver.requestData(
      json.encode(
        TestConfiguration(
          resolution: properties.resolution,
          platform: properties.platform,
          route: '/',
        ),
      ),
    );
  }

  test('display timeline page', () async {
    await restart();

    await driver.waitFor(find.byType('TimelinePage'));

    await screenshot.takeScreenshot('display page');
  });
}
