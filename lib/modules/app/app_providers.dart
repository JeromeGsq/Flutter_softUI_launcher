import 'package:flutter/widgets.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    /*
    return MultiProvider(
      providers: [],
      child: child,
    );
    */
    return child;
  }
}
