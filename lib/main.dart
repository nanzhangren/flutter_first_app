import 'package:flutter/material.dart';
import './calendar.dart';
import './common/resource.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Resource.appTitle,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new HomePage(title: Resource.appTitle)
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10.0),
        children: <Widget>[
          new Calendar()
        ]
      )
    );
  }
}
