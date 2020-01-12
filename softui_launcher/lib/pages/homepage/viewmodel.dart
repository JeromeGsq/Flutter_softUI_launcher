import 'dart:core';

import 'package:softui_launcher/base/base_viewmodel.dart';

class HomeModel extends BaseModel {
  bool isBusy;
  int pageIndex;
  String title;

  HomeModel({
    this.isBusy = false,
    this.pageIndex = 1,
    this.title = '',
  });

  @override
  Future<void> initialize() async {}

  Future<void> add() async {
    pageIndex++;
    notifyListeners();
  }
}
