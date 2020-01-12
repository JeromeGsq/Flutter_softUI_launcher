import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:softui_launcher/pages/homepage/viewmodel.dart';
import 'package:softui_launcher/theme/app_colors.dart';
import 'package:softui_launcher/widgets/nm_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeModel _model = HomeModel();

  @override
  void initState() {
    this._model.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<HomeModel>(
      model: this._model,
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        body: ScopedModelDescendant<HomeModel>(
          builder: (context, child, model) {
            return buildPage(model, context);
          },
        ),
      ),
    );
  }

  Widget buildPage(HomeModel model, BuildContext context) {
    return Center(
      child: NMButton(
        onTap: () {},
        width: 100,
        height: 100,
      ),
    );
  }
}
