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
  int yearDropdownValue = new DateTime.now().year;
  int monthDropdownValue = new DateTime.now().month;
  int firstShownWeekday = 7;
  List<int> shownDays;

  onYearChange(int value) {
    setState(() {
      yearDropdownValue = value;
      shownDays = UtilDay.getMonthShownDays(value, monthDropdownValue, firstShownWeekday);
    });
  }

  onMonthChange(int value) {
    setState(() {
      monthDropdownValue = value;
      shownDays = UtilDay.getMonthShownDays(yearDropdownValue, value, firstShownWeekday);
    });
  }

  onLeftButtonClicked() {
    setState(() {
      // 边界值判断
      if (yearDropdownValue == UtilDay.minYear && monthDropdownValue == 1) {
        return;
      }
      if (monthDropdownValue == 1) {
        yearDropdownValue -= 1;
        monthDropdownValue = 12;
      } else {
        monthDropdownValue -= 1;
      }
      shownDays = UtilDay.getMonthShownDays(yearDropdownValue, monthDropdownValue, firstShownWeekday);
    });
  }

  onRightButtonClicked() {
    setState(() {
      if (monthDropdownValue == 12) {
        yearDropdownValue += 1;
        monthDropdownValue = 1;
      } else {
        monthDropdownValue += 1;
      }
      shownDays = UtilDay.getMonthShownDays(yearDropdownValue, monthDropdownValue, firstShownWeekday);
    });
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
      value: yearDropdownValue,
      underline: new Container(),
      onChanged: (newValue) {
        onYearChange(newValue);
      }
    );
  }

  DropdownButton getMonthButton() {
    List<DropdownMenuItem> dropdownItems = <DropdownMenuItem>[];
    for (int i = 1; i <= 12; i++) {
      dropdownItems.add(new DropdownMenuItem(
        child: new Text(i.toString() + '月'),
        value: i,
      ));
    }
    return new DropdownButton(
      items: dropdownItems,
      hint: new Text('请选择：'),
      value: monthDropdownValue,
      underline: new Container(),
      onChanged: (newValue) {
        onMonthChange(newValue);
      }
    );
  }

  Row getButtonView() {
    return new Row(
      children: [
        new Expanded(
          flex: 3,
          child: getYearButton(UtilDay.getYears())
        ),
        new Expanded(
          flex: 3,
          child: getMonthButton()
        ),
        new Expanded(
          flex: 2,
          child: new FlatButton(
            child: new Text(
              '<',
              style: new TextStyle(
                fontSize: 20.0
              )
            ),
            onPressed: () {
              onLeftButtonClicked();
            },
          )
        ),
        new Expanded(
          flex: 2,
          child: new FlatButton(
            child: new Text(
              '>',
              style: new TextStyle(
                fontSize: 20.0
              )
            ),
            onPressed: () {
              onRightButtonClicked();
            },
          )
        )
      ]
    );
  }

  GridView getWeekTitleView() {
    final weekTitleArr = <Container>[];
    ['日', '一', '二', '三', '四', '五', '六'].forEach((weekFlag) {
      weekTitleArr.add(
        new Container(
          alignment: Alignment.center,
          color: Colors.blue,
          child: new Text(
            weekFlag,
            style: new TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold
            )
          ),
        )
      );
    });
    return new GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 7,
      childAspectRatio: 1.5,
      mainAxisSpacing: 3.0,
      crossAxisSpacing: 3.0,
      children: weekTitleArr,
    );
  }

  GridView getMonthView(days) {
    List<Container> gridData = <Container>[];
    days.forEach((int item) {
      gridData.add(new Container(
          alignment: Alignment.center,
          color: Colors.blue,
          child: new Text(
            item.toString(),
            style: new TextStyle(
              color: Colors.white,
              fontSize: 14
            )
          )
        )
      );
    });
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
  void initState() {
    super.initState();
    shownDays = UtilDay.getCurrentMonthShownDays(firstShownWeekday);
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
          Padding(
            padding: EdgeInsets.only(bottom: 6.0),
            child: getWeekTitleView(),
          ),
          getMonthView(shownDays)
        ]
      )
    );
  }
}
