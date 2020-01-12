import 'dart:core';

import 'package:softui_launcher/base/base_viewmodel.dart';

class HomeModel extends BaseModel {
  bool isBusy;
  String title;

  HomeModel({
    this.isBusy = false,
    this.title = '',
  });

  @override
  Future<void> initialize() async {}
}
