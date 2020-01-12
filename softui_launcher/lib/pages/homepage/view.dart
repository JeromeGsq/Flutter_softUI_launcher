import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:softui_launcher/model/appcell.dart';
import 'package:softui_launcher/pages/homepage/viewmodel.dart';
import 'package:softui_launcher/theme/app_colors.dart';
import 'package:softui_launcher/theme/app_text_styles.dart';
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
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    SystemChrome.setEnabledSystemUIOverlays([]);

    return ScopedModel<HomeModel>(
      model: this._model,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: AppColors.smartGray,
          body: ScopedModelDescendant<HomeModel>(
            builder: (context, child, model) {
              return buildPage(model, context);
            },
          ),
        ),
      ),
    );
  }

  Widget buildPage(HomeModel model, BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildAppBar(),
            SizedBox(height: 16),
            buildLine(categoryLabel: 'Apps', icon: Icons.apps),
            buildLine(categoryLabel: 'Films', icon: Icons.movie),
            buildLine(categoryLabel: 'Jeux', icon: Icons.gamepad),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget buildLine({String categoryLabel = '', IconData icon, List<AppCell> apps}) {
    final kverticalPadding = 24.0;
    final kcirclePadding = 8.0;
    final kheightSize = 110.0;

    return Container(
      height: kheightSize + (kverticalPadding * 2),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: kverticalPadding),
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 999,
        itemBuilder: (_, index) {
          return index == 0
              ? Padding(
                  padding: const EdgeInsets.only(right: 32),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.all(kcirclePadding),
                        child: NMButton(
                          onTap: () {},
                          icon: icon,
                          radius: kheightSize / 2,
                        ),
                      ),
                      Text(
                        categoryLabel,
                        style: AppTextStyles.label.copyWith(fontSize: 12),
                      ),
                      Spacer(),
                    ],
                  ),
                )
              : Transform.scale(
                  scale: true ? 1 : 0.9,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: NMButton(
                            width: 150,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            categoryLabel,
                            style: AppTextStyles.label.copyWith(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }

  Widget buildAppBar() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: NMButton(
            alignmentDirectional: AlignmentDirectional.centerStart,
            width: 300,
            child: Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Row(
                children: <Widget>[
                  Icon(Icons.mic, color: AppColors.fCL),
                  SizedBox(width: 10),
                  Text(
                    "Rechercher une application ...",
                    style: AppTextStyles.label,
                  ),
                ],
              ),
            ),
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: NMButton(
            onTap: () {},
            icon: Icons.settings,
          ),
        ),
      ],
    );
  }
}
