import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:launcher_assist/launcher_assist.dart';
import 'package:provider/provider.dart';
import 'package:softui_launcher/modules/home/view_model.dart';
import 'package:softui_launcher/widgets/app_item.dart';
import 'package:softui_launcher/widgets/nm_box.dart';
import 'package:softui_launcher/widgets/nm_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider.value(
          value: HomeViewModel()..load(),
          child: _View(),
        ),
      ),
    );
  }
}

class _View extends StatefulWidget {
  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<_View> {
  List<dynamic> _apps;
  List<dynamic> _favoritesApps;

  bool _isCurrentAppFavorite = false;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _apps = [];
    _favoritesApps = [];
    _currentPage = 0;

    LauncherAssist.getAllApps().then((apps) {
      setState(() {
        _apps = apps;
      });
    });
  }

  _onPageChanged({int index}) {
    _currentPage = index;
    print(index);
    setState(() {
      _isCurrentAppFavorite = _favoritesApps.contains(_apps[_currentPage]);
      print(_isCurrentAppFavorite);
    });
  }

  _addFavorite({dynamic app}) {
    setState(() {
      if (_favoritesApps.contains(app)) {
        _favoritesApps.remove(app);
      } else {
        _favoritesApps.add(app);
      }
      _isCurrentAppFavorite = _favoritesApps.contains(_apps[_currentPage]);
    });
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(mainColor);
    FlutterStatusbarcolor.setNavigationBarColor(mainColor);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: mainColor,
        body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    NMButton(
                      onTap: () {},
                      icon: Icons.settings,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              CarouselSlider.builder(
                scrollPhysics: BouncingScrollPhysics(),
                enableInfiniteScroll: false,
                onPageChanged: (index) => _onPageChanged(index: index),
                viewportFraction: 0.5,
                height: 190,
                enlargeCenterPage: true,
                itemCount: _apps?.length,
                itemBuilder: (context, index) {
                  return AppItem(app: _apps[index]);
                },
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 36),
                child: NMButton(
                  onTap: () {
                    _addFavorite(app: _apps[_currentPage]);
                  },
                  width: 65,
                  height: 65,
                  radius: 65 / 2,
                  icon: _isCurrentAppFavorite ? Icons.star : Icons.star_border,
                ),
              ),
              Center(
                child: NMButton(
                  onTap: () {
                    LauncherAssist.launchApp(_apps[_currentPage]["package"]);
                  },
                  width: 200,
                  height: 200,
                  radius: 100,
                  icon: Icons.play_arrow,
                  iconSize: 60,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 30, bottom: 10),
                child: Text(
                  'Favorites :',
                  style: TextStyle(
                    color: fCD,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                child: NMButton(
                  height: 100,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _favoritesApps?.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: NMButton(
                          width: 70,
                          onTap: () {
                            LauncherAssist.launchApp(_favoritesApps[index]["package"]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.memory(
                              _favoritesApps[index]["icon"],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
