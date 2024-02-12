import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:realm_flutter/src/sample_feature/sample_item.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  final realm = Realm(Configuration.local([SampleItem.schema]));
  final allItems = realm.all<SampleItem>();

  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  runApp(MyApp(
    settingsController: settingsController,
    items: allItems,
  ));
}
