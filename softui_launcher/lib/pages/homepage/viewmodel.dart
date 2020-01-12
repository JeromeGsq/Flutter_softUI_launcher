import 'dart:core';

import 'package:launcher_assist/launcher_assist.dart';
import 'package:softui_launcher/base/base_viewmodel.dart';
import 'package:softui_launcher/model/appcell.dart';

class HomeModel extends BaseModel {
  bool isBusy;
  String title;

  List<AppCell> apps = [];

  HomeModel({
    this.isBusy = false,
    this.title = '',
  });

  @override
  Future<void> initialize() async {
    var applications = await LauncherAssist.getAllApps();

    for (var app in applications) {
      apps.add(
        AppCell(
          label: app["label"],
          package: app["package"],
          icon: app["icon"],
        ),
      );
    }

    notifyListeners();
  }
}
