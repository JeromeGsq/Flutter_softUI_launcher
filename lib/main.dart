import 'package:flutter/services.dart';
import 'package:launcher_assist/launcher_assist.dart';
import 'package:softui_launcher/widgets/nm_box.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:softui_launcher/widgets/nm_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainCard(),
    );
  }
}

class MainCard extends StatefulWidget {
  @override
  _MainCardState createState() => _MainCardState();
}

class _MainCardState extends State<MainCard> {
  int _numberOfInstalledApps = 0;
  var _apps;

  @override
  void initState() {
    super.initState();

    LauncherAssist.getAllApps().then((apps) {
      setState(() {
        _apps = apps;
        _numberOfInstalledApps = apps?.length;
      });
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
              SizedBox(
                height: 190,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _numberOfInstalledApps,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        width: 150,
                        height: 190,
                        child: NMButton(
                          onTap: () {
                            LauncherAssist.launchApp(_apps[index]["package"]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _apps[index]["package"].toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 36),
                child: NMButton(
                  onTap: () {},
                  width: 65,
                  height: 65,
                  radius: 65 / 2,
                  icon: Icons.star,
                ),
              ),
              Center(
                child: NMButton(
                  onTap: () {},
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*

Padding( 
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Text(
                'Soft Launcher',
                style: TextStyle(
                  color: fCD,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            */
