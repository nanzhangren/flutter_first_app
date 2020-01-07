import 'package:flutter/material.dart';
import './common/resource.dart';
import './calendar/calendar.dart';
import './plan/plan.dart';

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
  int _selectedIndex = 1;
  final _widgetOptions = [
    new ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(10.0),
      children: <Widget>[
        new Calendar()
      ]
    ),
    new Plan(),
    Text('Index 2: 我的')
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(52),
        child: AppBar(
          title: Text('流水账'),
          centerTitle: true,
          backgroundColor: Colors.white70,
          brightness: Brightness.light
        )
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_view_day),
            title: Text('日历')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            title: Text('计划')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('我的')
          )
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}
