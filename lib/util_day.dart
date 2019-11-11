
class UtilDay {

  static int getOneYearDays(year) {
    if (year % 4 == 0 && year % 100 != 0) {
      return 366;
    } else {
      return 365;
    }
  }

  static int getOneMonthDays(year, month) {
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

  static int getLeftDaysOfMonth(year, month, day) {
    final monthDays = getOneMonthDays(year, month);
    return monthDays - day;
  }

  static int getPastDaysOfYear(year, month, day) {
    int pastDays = 0;
    for (int i = 1; i < month; i++) {
      pastDays += getOneMonthDays(year, month);
    }
    pastDays += day;
    return pastDays;
  }

  static int getLeftDaysOfYear(year, month, day) {
    int leftDays = getLeftDaysOfMonth(year, month, day);
    for (int i = month + 1; i <= 12; i++) {
      leftDays += getOneMonthDays(year, month);
    }
    return leftDays;
  }

  static int getDaysToTheDay(fromYear, fromMonth, fromDay, toYear, toMonth, toDay) {
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
    for (int i = 1900; i <= 2050; i++) {
      yearArr.add(i);
    }
    return yearArr;
  }

}
