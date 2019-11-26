
class UtilDay {

  static const minYear = 1900;
  static const maxYear = minYear + 150;

  static int getOneYearDays(int year) {
    if (year % 4 == 0 && year % 100 != 0) {
      return 366;
    } else {
      return 365;
    }
  }

  static int getOneMonthDays(int year, int month) {
    if ([1, 3, 5, 7, 8, 10, 12].contains(month)) {
      return 31;
    } else if (month == 2) {
      if (year % 4 == 0 && year % 100 != 0) {
        return 29;
      } else {
        return 28;
      }
    } else {
      return 30;
    }
  }

  static int getLeftDaysOfMonth(int year, int month, int day) {
    final monthDays = getOneMonthDays(year, month);
    return monthDays - day;
  }

  static int getPastDaysOfYear(int year, int month, int day) {
    int pastDays = 0;
    for (int i = 1; i < month; i++) {
      pastDays += getOneMonthDays(year, month);
    }
    pastDays += day;
    return pastDays;
  }

  static int getLeftDaysOfYear(int year, int month, int day) {
    int leftDays = getLeftDaysOfMonth(year, month, day);
    for (int i = month + 1; i <= 12; i++) {
      leftDays += getOneMonthDays(year, month);
    }
    return leftDays;
  }

  static int getDaysToTheDay(int fromYear, int fromMonth, int fromDay, int toYear, int toMonth, int toDay) {
    // TODO: 参数校验，同一年时不能这么计算
    final fromYearLeftDays = getLeftDaysOfYear(fromYear, fromMonth, fromDay);
    final toYearPastDays = getPastDaysOfYear(toYear, toMonth, toDay);
    int totalDays = fromYearLeftDays + toYearPastDays;
    for (int i = fromYear + 1; i < toYearPastDays; i++) {
      totalDays += getOneYearDays(i);
    }
    return totalDays;
  }

  static List<int> getYears() {
    // TODO: 此处可以添加缓存，只计算一次即可
    List<int> yearArr = <int>[];
    for (int i = minYear; i <= maxYear; i++) {
      yearArr.add(i);
    }
    return yearArr;
  }

  // TODO: 上一月、下一月剩余天数计算单独抽离方法
  static List<int> getMonthShownDays(year, month, [int firstShownWeekday = 7]) {
    final shownDays = <int>[];

    /* 计算本月第一周在1号之前的天数 */
    // 计算上个月天数有两种情况：
    // （1）本月第一天星期数 >= 开始星期数【if 逻辑】
    //      本月第一周剩余天数 = 本月第一天星期数 - 开始星期数
    // （2）本月第一天星期数 < 开始星期数【else 逻辑】
    //      本月第一周剩余天数分为两段，星期日之前 + 星期日之后
    //      星期日之前天数 = 7 - 开始星期数 + 1
    //      星期日之后天数 = 本月第一天星期数 - 1
    final monthFirstWeekDay = new DateTime(year, month, 1).weekday;
    int previousMonthDays = 0;
    if (monthFirstWeekDay >= firstShownWeekday) {
      previousMonthDays += monthFirstWeekDay - firstShownWeekday;
    } else {
      previousMonthDays += 8 - firstShownWeekday;
      previousMonthDays += monthFirstWeekDay - 1;
    }
    final lastMonthDays = getOneMonthDays(year, month - 1);
    // 第一个展示的上月日期
    int firstShownDay = lastMonthDays - previousMonthDays + 1;
    // 上一月剩余日期
    for (int i = firstShownDay; i <= lastMonthDays; i++) {
      shownDays.add(i);
    }

    /* 本月日期 */
    final currentMonthDays = getOneMonthDays(year, month);
    for (int i = 1; i <= currentMonthDays; i++) {
      shownDays.add(i);
    }

    /* 计算本月最后一周在最后一天之后的天数 */
    // 计算下个月天数有两种情况：
    // （1）结束星期数 >= 本月最后一天星期数【if 逻辑】
    //      本月最后一周剩余天数 = 结束星期数 - 本月最后一天星期数
    // （2）结束星期数 < 本月最后一天星期数【else 逻辑】
    //      本月最后一周剩余天数分为两段，星期日之前 + 星期日之后
    //      星期日之前天数 = 7 - 本月最后一天星期数
    //      星期日之后天数 = 结束星期数
    final monthLastWeekDay = new DateTime(year, month, currentMonthDays).weekday;
    final lastShownWeekday = firstShownWeekday == 1 ? 7 : firstShownWeekday - 1;
    int nextMonthDays = 0;
    if (lastShownWeekday >= monthLastWeekDay) {
      nextMonthDays += lastShownWeekday - monthLastWeekDay;
    } else {
      nextMonthDays += 7 - monthLastWeekDay;
      nextMonthDays += lastShownWeekday;
    }
    
    /* 日历显示 6 行，所以周数不够时下个月天数增加一周 */
    if (shownDays.length + nextMonthDays == 35) {
      nextMonthDays += 7;
    }

    /* 润 2 月只有 28 天，有可能不够 6 行，此处需要进行判断 */
    if (shownDays.length + nextMonthDays == 35 /* (5 * 7) */) {
      nextMonthDays += 7;
    }

    // 添加下个月天数
    for (int i = 1; i <= nextMonthDays; i++) {
      shownDays.add(i);
    }
    return shownDays;
  }

  static List<int> getCurrentMonthShownDays([int firstShownWeekday = 7]) {
    DateTime currentDateTime = new DateTime.now();
    final year = currentDateTime.year;
    final month = currentDateTime.month;
    return getMonthShownDays(year, month, firstShownWeekday);
  }
}
