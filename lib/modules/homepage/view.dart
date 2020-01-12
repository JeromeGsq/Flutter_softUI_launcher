import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softui_launcher/core/widgets/view.dart';
import 'package:softui_launcher/modules/homepage/view_model.dart';

class HomepageView extends StatelessWidget {
  const HomepageView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider.value(
          value: HomepageViewModel()..load(),
          child: const _View(),
        ),
      ),
    );
  }
}

class _View extends StatelessWidget {
  const _View({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<HomepageViewModel>(
      onEvent: (context, event) {},
      idleBuilder: (context, vm) {
        return Scaffold(
          body: buildPage(vm, context),
        );
      },
    );
  }

  Widget buildPage(HomepageViewModel vm, BuildContext context) {
    return Container();
  }
}
