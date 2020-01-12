import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:softui_launcher/pages/homepage/viewmodel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeModel _model = HomeModel();

  @override
  void initState() {
    this._model.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<HomeModel>(
      model: this._model,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Center(
            child: ScopedModelDescendant<HomeModel>(
              builder: (context, child, model) {
                return Text(model.title);
              },
            ),
          ),
        ),
        body: ScopedModelDescendant<HomeModel>(
          builder: (context, child, model) {
            return buildPage(model, context);
          },
        ),
      ),
    );
  }

  Widget buildPage(HomeModel model, BuildContext context) {
    return Column(
      children: <Widget>[
        Container(),
        Text(model.pageIndex.toString()),
        MaterialButton(
          onPressed: () {
            model.add();
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
