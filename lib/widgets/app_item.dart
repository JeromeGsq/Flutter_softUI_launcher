import 'package:softui_launcher/widgets/nm_box.dart';
import 'package:softui_launcher/widgets/nm_button.dart';
import 'package:flutter/widgets.dart';

class AppItem extends StatelessWidget {
  const AppItem({
    Key key,
    @required app,
  })  : app = app,
        super(key: key);

  final app;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: 150,
        height: 190,
        child: NMButton(
          forcePressed: true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 30),
                  child: Image.memory(
                    app["icon"],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      app["label"].toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: fCD,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
