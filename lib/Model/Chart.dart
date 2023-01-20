import 'package:charts_flutter/flutter.dart';

class StatusBarChart {
  final String status;
  final int numStatus;
  final Color barColor;
  StatusBarChart(this.status, this.numStatus, this.barColor);
}
class LogYearChart {
  final String month;
  final int numInMonth;
  LogYearChart(this.month, this.numInMonth);
}
class LogMonthChart {
  final int day;
  final int numInDay;
  LogMonthChart(this.day, this.numInDay);
}
class LogDayChart {
  final int time;
  final int numInTime;
  LogDayChart(this.time, this.numInTime);
}