import 'package:flutter/material.dart';
import './util_day.dart';
import './util_week.dart';

class CalendarDay extends StatelessWidget {
  CalendarDay({
    Key key,
    @required this.dayValue,
    @required this.dayIndex,
    @required this.isSelected,
    @required this.isCurrentDay,
    @required this.onSelected
  }) : super(key: key);

  final String dayValue;
  final int dayIndex;
  final bool isSelected;
  final bool isCurrentDay;
  final Function onSelected;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        onSelected(dayIndex);
      },
      child: new Container(
        alignment: Alignment.center,
        decoration: new BoxDecoration(
          color: isCurrentDay ? Colors.orange : Colors.white,
          border: isSelected ? Border.all(
            width: 3.0,
            color: Colors.orange,
            style: BorderStyle.solid
          ) : null
        ),
        child: new Text(
          dayValue,
          style: new TextStyle(
            color: isCurrentDay ? Colors.white : Colors.black,
            fontSize: 14
          )
        )
      )
    );
  }
}

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
  int selectedDayIndex = 0;
  int currentDayIndex = 0;

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

  onSelectedDayChange(int newDayIndex) {
    setState(() {
      selectedDayIndex = newDayIndex;
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

  GridView getWeekTitleView() {
    final weekTitleViewArr = <CalendarDay>[];
    final weekTitleArr = UtilWeek.getWeekTitle(firstShownWeekday);
    weekTitleArr.forEach((weekFlag) {
      weekTitleViewArr.add(
        new CalendarDay(
          dayValue: weekFlag,
          dayIndex: -1,
          isSelected: false,
          isCurrentDay: false,
          onSelected: (int newDayIndex) {
            // do nothing
          }
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
    List<CalendarDay> gridData = <CalendarDay>[];
    int count = 0;
    days.forEach((int item) {
      count++;
      gridData.add(
        new CalendarDay(
          dayValue: item.toString(),
          dayIndex: count,
          isSelected: count == selectedDayIndex,
          isCurrentDay: count == currentDayIndex,
          onSelected: onSelectedDayChange,
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
    currentDayIndex = shownDays.indexOf(1) + new DateTime.now().day;

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
          child: getWeekTitleView(),
        ),
        getMonthView(shownDays)
      ]
    );
  }
}
