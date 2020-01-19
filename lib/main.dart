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
  int _selectedBottomNavIndex = 0;
  int _selectedYear;
  int _selectedMonth;
  int _selectedDay;

  void _onSelectedChange(int selectedYear, int selectedMonth, int selectedDay) {
    _selectedYear = selectedYear;
    _selectedMonth = selectedMonth;
    _selectedDay = selectedDay;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedBottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _widgetOptions = [
      new ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10.0),
        children: <Widget>[
          new Calendar(
            selectedYear: _selectedYear,
            selectedMonth: _selectedMonth,
            selectedDay: _selectedDay,
            onSelectedChange: _onSelectedChange
          )
        ]
      ),
      new Plan(_selectedYear, _selectedMonth, _selectedDay),
      new ListView(
        shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        children: <Widget>[
          new Text('Index 2: 我的')
        ]
      )
    ];
    return new Scaffold(
      appBar: new PreferredSize(
        preferredSize: Size.fromHeight(52),
        child: new AppBar(
          title: new Text(Resource.appTitle),
          centerTitle: true,
          backgroundColor: Colors.white70,
          brightness: Brightness.light,
          actions: _selectedBottomNavIndex != 2 ? <Widget>[
            new IconButton(
              icon: new Icon(Icons.add_circle_outline),
              color: Colors.black,
              onPressed: () {
                //
              }
            )
          ] : []
        )
      ),
      body: _widgetOptions[_selectedBottomNavIndex],
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.calendar_view_day),
            title: new Text(Resource.mainBottomNavCalendar)
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.event),
            title: new Text(Resource.mainBottomNavPlan)
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.person),
            title: new Text(Resource.mainBottomNavMe)
          )
        ],
        currentIndex: _selectedBottomNavIndex,
        fixedColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}
