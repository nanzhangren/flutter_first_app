import 'package:flutter/material.dart';
import '../common/util_day.dart';
import '../common/util_week.dart';
import '../common/resource.dart';

class _CalendarDay extends StatelessWidget {
  final String dayValue;
  final bool isSelected;
  final bool isCurrentDay;
  final Function onSelected;
  final bool isPreviousMonthDay;
  final bool isNextMonthDay;

  _CalendarDay({
    Key key,
    @required this.dayValue,
    @required this.isSelected,
    @required this.isCurrentDay,
    @required this.onSelected,
    this.isPreviousMonthDay = false,
    this.isNextMonthDay = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color fontColor = Colors.black;
    Color backColor = Colors.white;

    if (isPreviousMonthDay || isNextMonthDay) {
      fontColor = Colors.grey;
    }
    if (isCurrentDay) {
      fontColor = Colors.white;
      backColor = Colors.orange;
    }

    return new GestureDetector(
      onTap: () {
        onSelected(dayValue, isPreviousMonthDay, isNextMonthDay);
      },
      child: new Container(
        alignment: Alignment.center,
        decoration: new BoxDecoration(
          color: backColor,
          border: isSelected ? Border.all(
            width: 3.0,
            color: Colors.orange,
            style: BorderStyle.solid
          ) : null
        ),
        child: new Text(
          dayValue,
          style: new TextStyle(
            color: fontColor,
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
  int _selectedYear = new DateTime.now().year;
  int _selectedMonth = new DateTime.now().month;
  List<DropdownMenuItem> _yearDropdownItems = <DropdownMenuItem>[];
  int _firstShownWeekday = 7;
  List<int> _shownDays;
  int _maxYear = UtilDay.maxYear;
  int _selectedDay = 0;

  _onYearChange(int value) {
    setState(() {
      _selectedYear = value;
      _shownDays = UtilDay.getMonthShownDays(value, _selectedMonth, _firstShownWeekday);
    });
  }

  _onMonthChange(int value) {
    setState(() {
      _selectedMonth = value;
      _shownDays = UtilDay.getMonthShownDays(_selectedYear, value, _firstShownWeekday);
    });
  }

  _onLeftButtonClicked() {
    setState(() {
      // Varify the minimum year.
      if (_selectedYear == UtilDay.minYear && _selectedMonth == 1) {
        return;
      }
      if (_selectedMonth == 1) {
        _selectedYear -= 1;
        _selectedMonth = 12;
      } else {
        _selectedMonth -= 1;
      }
      _shownDays = UtilDay.getMonthShownDays(_selectedYear, _selectedMonth, _firstShownWeekday);
    });
  }

  _onRightButtonClicked() {
    setState(() {
      if (_selectedMonth == 12) {
        _selectedYear += 1;
        _selectedMonth = 1;
      } else {
        _selectedMonth += 1;
      }
      if (_selectedYear > _maxYear) {
        _maxYear = _selectedYear;
        _yearDropdownItems.add(
          new DropdownMenuItem(
            child: new Text(_selectedYear.toString() + '年'),
            value: _selectedYear
          )
        );
      }
      _shownDays = UtilDay.getMonthShownDays(_selectedYear, _selectedMonth, _firstShownWeekday);
    });
  }

  _onSelectedDayChange(String newDayValue, bool isPreviousMonthDay, bool isNextMonthDay) {
    setState(() {
      _selectedDay = int.parse(newDayValue);
      if (isPreviousMonthDay) {
        _onLeftButtonClicked();
      } else if (isNextMonthDay) {
        _onRightButtonClicked();
      }
    });
  }

  _getCurrentDayIndex(List<int> days, int firstDayIndex, int lastDayIndex) {
    final DateTime currentDate = new DateTime.now();
    final int currentMonth = currentDate.month;
    final int currentDay = currentDate.day;
    int currentDayIndex = -1;

    // Current month is selected, the highlight day is in the middle of calendar view.
    if (_selectedMonth == currentMonth) {
      currentDayIndex = days.indexOf(currentDay, firstDayIndex);
    }
    // Previous month is selected, the highlight day may be in the bottom of calendar view.
    else if (_selectedMonth == currentMonth - 1) {
      currentDayIndex = days.indexOf(currentDay, lastDayIndex + 1);
    }
    // Next month is selected, the highlight day may be in the top of calendar view.
    else if (_selectedMonth == currentMonth + 1) {
      currentDayIndex = days.take(firstDayIndex).toList().indexOf(currentDay);
    }
    return currentDayIndex;
  }

  DropdownButton _getYearButton() {
    return new DropdownButton(
      items: _yearDropdownItems,
      hint: new Text(Resource.selectTip),
      value: _selectedYear,
      underline: new Container(),
      onChanged: (newValue) {
        _onYearChange(newValue);
      }
    );
  }

  DropdownButton _getMonthButton() {
    List<DropdownMenuItem> dropdownItems = List.generate(
      12,
      (index) => new DropdownMenuItem(
        child: new Text(index.toString() + Resource.monthUnit),
        value: index
      )
    );
    return new DropdownButton(
      items: dropdownItems,
      hint: new Text('请选择：'),
      value: _selectedMonth,
      underline: new Container(),
      onChanged: (newValue) {
        _onMonthChange(newValue);
      }
    );
  }

  Row _getButtonView() {
    return new Row(
      children: [
        new Expanded(
          flex: 3,
          child: _getYearButton()
        ),
        new Expanded(
          flex: 3,
          child: _getMonthButton()
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
              _onLeftButtonClicked();
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
              _onRightButtonClicked();
            },
          )
        )
      ]
    );
  }

  GridView _getWeekTitleView() {
    final weekTitleViewArr = <_CalendarDay>[];
    final weekTitleArr = UtilWeek.getWeekTitle(_firstShownWeekday);
    weekTitleArr.forEach((weekFlag) {
      weekTitleViewArr.add(
        new _CalendarDay(
          dayValue: weekFlag,
          isSelected: false,
          isCurrentDay: false,
          onSelected: (String newDayValue, bool isPreviousMonthDay, bool isNextMonthDay) {
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

  GridView _getMonthView(days) {
    final int firstDayIndex = days.indexOf(1);
    int lastDayIndex = days.lastIndexOf(1);

    // Verify the value of lastDayIndex.
    if (lastDayIndex == -1) {
      lastDayIndex = days.length - 1;
    } else {
      lastDayIndex -= 1;
    }

    final int selectedDayIndex = days.indexOf(_selectedDay, firstDayIndex);
    final int currentDayIndex = _getCurrentDayIndex(days, firstDayIndex, lastDayIndex);
    List<_CalendarDay> gridData = <_CalendarDay>[];
    int index = 0;
    days.forEach((int day) {
      gridData.add(
        new _CalendarDay(
          dayValue: day.toString(),
          isSelected: index == selectedDayIndex,
          isCurrentDay: index == currentDayIndex,
          onSelected: _onSelectedDayChange,
          isPreviousMonthDay: index < firstDayIndex,
          isNextMonthDay: index > lastDayIndex,
        )
      );
      index++;
    });

    return new GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      mainAxisSpacing: 3.0,
      crossAxisSpacing: 3.0,
      crossAxisCount: 7,
      childAspectRatio: 1.0,
      children: gridData
    );
  }

  @override
  void initState() {
    super.initState();

    _shownDays = UtilDay.getCurrentMonthShownDays(_firstShownWeekday);

    final yearArr = UtilDay.getYears();
    yearArr.forEach((year) {
      _yearDropdownItems.add(new DropdownMenuItem(
        child: new Text(year.toString() + Resource.yearUnit),
        value: year
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new ListView(
      shrinkWrap: true,
      children: <Widget>[
        _getButtonView(),
        Padding(
          padding: EdgeInsets.only(bottom: 6.0),
          child: _getWeekTitleView(),
        ),
        _getMonthView(_shownDays)
      ]
    );
  }
}
