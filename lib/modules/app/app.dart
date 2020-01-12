import 'package:softui_launcher/modules/app/app_providers.dart';
import 'package:flutter/material.dart';

import '../homepage/view.dart';

class App extends StatefulWidget {
  const App({
    Key key,
  }) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: MaterialApp(
        title: 'SoftUI Launcher',
        initialRoute: '/',
        routes: {
          '/': (context) => const HomepageView(),
        },
      ),
    );
  }
}
