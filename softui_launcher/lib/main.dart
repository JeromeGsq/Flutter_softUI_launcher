import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:softui_launcher/pages/homepage/view.dart';

void main() {
  runApp(
    FlutterScopedModelApp(title: "Flutter ScopedModel App"),
  );
}

class FlutterScopedModelApp extends StatefulWidget {
  final String title;

  FlutterScopedModelApp({Key key, this.title}) : super(key: key);

  @override
  _FlutterScopedModelAppState createState() => _FlutterScopedModelAppState();
}

class _FlutterScopedModelAppState extends State<FlutterScopedModelApp> {
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      // needed for AndroidTV to be able to select
      shortcuts: {LogicalKeySet(LogicalKeyboardKey.select): const Intent(ActivateAction.key)},
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (key) {
          print(key);
        },
        child: MaterialApp(
          title: widget.title,
          onGenerateRoute: _getRoute,
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        ),
      ),
    );
  }

  /// Navigation
  Route _getRoute(RouteSettings settings) {
    switch (settings.name) {
      // case '/movie_details':
      //   return _buildRoute(settings, MovieDetailsPage(settings.arguments));
      default:
        return _buildRoute(settings, HomePage());
    }
  }

  // Build route
  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }
}
