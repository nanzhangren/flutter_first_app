
class UtilWeek {

  static getWeekTitle([int firstShownWeekday = 7]) {
    List<String> weekArr = ['一', '二', '三', '四', '五', '六', '日'];
    final takenNum = firstShownWeekday - 1;
    final previousArr = weekArr.skip(takenNum).take(7 - takenNum).toList();
    final nextArr = weekArr.take(takenNum).toList();
    previousArr.addAll(nextArr);
    return previousArr;
  }

}
