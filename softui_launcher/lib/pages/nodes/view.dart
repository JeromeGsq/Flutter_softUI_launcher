import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NodesPage extends StatelessWidget {
  const NodesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(width: 100),
              Button(),
              Button(),
              SizedBox(width: 100),
              SizedBox(width: 100),
              Button(),
              Button(),
            ],
          ),
          Row(
            children: <Widget>[
              Button(),
              Button(),
              SizedBox(width: 100),
              Button(),
              Button(),
            ],
          ),
          Row(
            children: <Widget>[
              Button(),
              SizedBox(width: 100),
              Button(),
              Button(),
              SizedBox(width: 100),
              Button(),
            ],
          ),
        ],
      ),
    );
  }
}

class Button extends StatefulWidget {
  const Button({
    Key key,
  }) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  FocusNode _node;

  @override
  void initState() {
    _node = FocusNode();
    _node.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RawMaterialButton(
        fillColor: _node.hasFocus ? Colors.red : Colors.grey,
        focusNode: _node,
        onPressed: () {
          print("Hello");
        },
        child: Text("1"),
      ),
    );
  }
}
