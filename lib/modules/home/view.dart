import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:launcher_assist/launcher_assist.dart';
import 'package:provider/provider.dart';
import 'package:softui_launcher/core/widgets/view.dart';
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
        child: ChangeNotifierProvider<HomeViewModel>(
          create: (context) => HomeViewModel()..load(),
          child: const _View(),
        ),
      ),
    );
  }
}

class _View extends StatefulWidget {
  const _View({
    Key key,
  }) : super(key: key);

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<_View> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(mainColor);
    FlutterStatusbarcolor.setNavigationBarColor(mainColor);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return View<HomeViewModel>(
      onEvent: (context, event) {},
      idleBuilder: (context, vm) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: mainColor,
            body: buildPage(vm),
          ),
        );
      },
    );
  }

  Widget buildPage(HomeViewModel vm) {
    return Padding(
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
            onPageChanged: (index) => vm.onPageChanged(index: index),
            viewportFraction: 0.5,
            height: 190,
            enlargeCenterPage: true,
            itemCount: vm?.apps?.length ?? 0,
            itemBuilder: (context, index) {
              return AppItem(app: vm.apps[index]);
            },
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 36),
            child: NMButton(
              onTap: () {
                vm.addFavorite(app: vm.apps[vm.currentPage]);
              },
              width: 65,
              height: 65,
              radius: 65 / 2,
              icon: vm.isCurrentAppFavorite ? Icons.star : Icons.star_border,
            ),
          ),
          Center(
            child: NMButton(
              onTap: () {
                LauncherAssist.launchApp(vm.apps[vm.currentPage]["package"]);
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
                itemCount: vm?.favoritesApps?.length ?? 0,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: NMButton(
                      width: 70,
                      onTap: () {
                        LauncherAssist.launchApp(vm.favoritesApps[index]["package"]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.memory(
                          vm.favoritesApps[index]["icon"],
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
    );
  }
}
