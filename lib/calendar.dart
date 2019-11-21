import 'package:flutter/material.dart';
import './util_day.dart';
import './util_week.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  int yearDropdownValue = new DateTime.now().year;
  int monthDropdownValue = new DateTime.now().month;
  List<DropdownMenuItem> yearDropdownItems = <DropdownMenuItem>[];
  int firstShownWeekday = 7;
  List<int> shownDays;
  int maxYear = UtilDay.maxYear;

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
      if (yearDropdownValue > maxYear) {
        maxYear = yearDropdownValue;
        yearDropdownItems.add(
          new DropdownMenuItem(
            child: new Text(yearDropdownValue.toString() + '年'),
            value: yearDropdownValue
          )
        );
      }
      shownDays = UtilDay.getMonthShownDays(yearDropdownValue, monthDropdownValue, firstShownWeekday);
    });
  }

  DropdownButton getYearButton() {
    return new DropdownButton(
      items: yearDropdownItems,
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
          child: getYearButton()
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

  GridView getWeekTitleView(BuildContext context) {
    final weekTitleViewArr = <FlatButton>[];
    final weekTitleArr = UtilWeek.getWeekTitle(firstShownWeekday);
    weekTitleArr.forEach((weekFlag) {
      weekTitleViewArr.add(
        new FlatButton(
          color: Colors.blue,
          shape: null,
          child: new Text(
            weekFlag,
            style: new TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold
            )
          ),
          onPressed: () {
            // context.shape = new BeveledRectangleBorder(
            //   side: new BorderSide(
            //     width: 2.0,
            //     color: Color.fromARGB(255, 255, 0, 0)
            //   )
            // );
          },
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
      children: weekTitleViewArr,
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

    final yearArr = UtilDay.getYears();
    yearArr.forEach((year) {
      yearDropdownItems.add(new DropdownMenuItem(
        child: new Text(year.toString() + '年'),
        value: year
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new ListView(
      shrinkWrap: true,
      children: <Widget>[
        getButtonView(),
        Padding(
          padding: EdgeInsets.only(bottom: 6.0),
          child: getWeekTitleView(context),
        ),
        getMonthView(shownDays)
      ]
    );
  }

}
