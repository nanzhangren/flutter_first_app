import 'package:flutter/material.dart';
import './util_day.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: '流水账'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int dropdownValue;

  List<Container> getGridData(days) {
    final monthDayArr = <Container>[];
    for (var i = 1; i <= days; i++) {
      final dayValue = i.toString();
      monthDayArr.add(
        new Container(
          alignment: Alignment.center,
          color: Colors.blue,
          child: new Text(
            dayValue,
            style: new TextStyle(
              color: Colors.white,
              fontSize: 14
            )
          ),
        )
      );
    }
    return monthDayArr;
  }

  DropdownButton getYearButton(List<int> yearArr) {
    List<DropdownMenuItem> dropdownItems = <DropdownMenuItem>[];
    yearArr.forEach((year) {
      dropdownItems.add(new DropdownMenuItem(
        child: new Text(year.toString() + '年'),
        value: year,
      ));
    });
    return new DropdownButton(
      items: dropdownItems,
      hint: new Text('请选择：'),
      value: dropdownValue,
      underline: new Container(),
      onChanged: (newValue) {
        onSelectChange(newValue);
      }
    );
  }

  onSelectChange(int value) {
    setState(() {
      dropdownValue = value;
    });
  }

  GridView getButtonView() {
    return new GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      childAspectRatio: 2,
      crossAxisSpacing: 4.0,
      children: <Widget>[
        getYearButton(UtilDay.getYears()),
        new FlatButton(
          child: new Text(
            '<',
            style: new TextStyle(
              fontSize: 30.0
            )
          ),
          onPressed: () {},
        ),
        new FlatButton(
          child: new Text(
            '>',
            style: new TextStyle(
              fontSize: 30.0
            )
          ),
          onPressed: () {},
        )
      ],
    );
  }

  GridView getDaysView(days) {
    List<Container> gridData = getGridData(days);
    return new GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      mainAxisSpacing: 3.0,
      crossAxisSpacing: 3.0,
      crossAxisCount: 7,
      childAspectRatio: 1.0,
      children: gridData,
    );
  }

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
          getButtonView(),
          getDaysView(31)
        ],
      )
    );
  }
}
