import 'package:creditcard_neumorphism/widgets/nm_box.dart';
import 'package:creditcard_neumorphism/widgets/nm_button.dart';
import 'package:creditcard_neumorphism/widgets/nm_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

double transLimit = 1250;

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

class MainCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: mainColor,
      statusBarColor: mainColor,
    ));

    return Scaffold(
      backgroundColor: mainColor,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Spacer(),
                Text(
                  'Soft Launcher',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: fCD,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                NMButton(
                  onTap: () {},
                  icon: Icons.settings,
                ),
              ],
            ),
            SizedBox(
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
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
            NMButton(
              alignmentDirectional: AlignmentDirectional.topStart,
              height: 100,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 15),
                child: Text(
                  'Favorites :',
                  style: TextStyle(
                    color: fCD,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
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
