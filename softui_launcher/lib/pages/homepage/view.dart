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
  HomeModel _model = HomeModel(isBusy: true);

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
              return model.isBusy ? Container() : buildPage(model, context);
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
            AppBar(model: model),
            SizedBox(height: 16),
            buildLine(
              categoryLabel: 'Apps',
              icon: Icons.apps,
              apps: model.apps,
              selectedCell: model.selectedCell,
            ),
            buildLine(
              categoryLabel: 'Films',
              icon: Icons.movie,
              apps: model.apps.where((w) => w.label[0] == 'S').toList(),
              selectedCell: model.selectedCell,
            ),
            buildLine(
              categoryLabel: 'Jeux',
              icon: Icons.gamepad,
              apps: model.apps.where((w) => w.label[0] == 'P').toList(),
              selectedCell: model.selectedCell,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLine({
    String categoryLabel = '',
    IconData icon,
    List<AppCell> apps,
    AppCell selectedCell,
  }) {
    final kverticalPadding = 24.0;
    final kcirclePadding = 8.0;
    final kheightSize = 110.0;

    return Container(
      height: kheightSize + (kverticalPadding * 2),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: kverticalPadding),
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: apps?.length,
        itemBuilder: (_, index) {
          return index == 0
              ? CategoryCircleWidget(
                  categoryLabel: categoryLabel,
                  icon: icon,
                  kcirclePadding: kcirclePadding,
                  kheightSize: kheightSize,
                )
              : AppCellWidget(
                  appCell: apps[index],
                  selected: _model.selectedCell == apps[index],
                  onTap: () {
                    _model.launch(apps[index]);
                  },
                );
        },
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({
    Key key,
    @required this.model,
  }) : super(key: key);

  final model;

  @override
  Widget build(BuildContext context) {
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
            onTap: () {
              model.launchSettings();
            },
            icon: Icons.settings,
          ),
        ),
      ],
    );
  }
}

class CategoryCircleWidget extends StatelessWidget {
  const CategoryCircleWidget({
    Key key,
    @required this.categoryLabel,
    @required this.icon,
    @required this.kcirclePadding,
    @required this.kheightSize,
  }) : super(key: key);

  final categoryLabel;
  final icon;
  final double kcirclePadding;
  final double kheightSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

class AppCellWidget extends StatefulWidget {
  AppCellWidget({
    @required this.appCell,
    @required this.selected,
    @required this.onTap,
    Key key,
  }) : super(key: key);

  final onTap;
  final appCell;
  final selected;

  @override
  _AppCellWidgetState createState() => _AppCellWidgetState();
}

class _AppCellWidgetState extends State<AppCellWidget> {
  double scale = 0.8;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: NMButton(
                onFocus: (hasFocus) {
                  setState(() {
                    scale = hasFocus ? 1 : 0.8;
                  });
                },
                onTap: widget.onTap,
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: widget.appCell?.icon == null
                      ? Icon(Icons.apps)
                      : Image.memory(
                          widget.appCell?.icon,
                        ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                widget.appCell?.label,
                style: AppTextStyles.label.copyWith(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
