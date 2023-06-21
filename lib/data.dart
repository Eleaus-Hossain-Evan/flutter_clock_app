import 'package:flutter_clock_app/providers/menu_info.dart';

import 'enums.dart';
import 'model/alarm_info.dart';

List<MenuInfo> menuItems = [
  MenuInfo(MenuType.clock,
      title: 'Clock', imageSource: 'assets/clock_icon.png'),
  MenuInfo(MenuType.alarm,
      title: 'Alarm', imageSource: 'assets/alarm_icon.png'),
  MenuInfo(MenuType.timer,
      title: 'Timer', imageSource: 'assets/timer_icon.png'),
  MenuInfo(MenuType.stopwatch,
      title: 'Stopwatch', imageSource: 'assets/stopwatch_icon.png'),
];

List<AlarmInfo> alarms = [
  AlarmInfo(
    id: 1,
    alarmDateTime: DateTime.now().add(const Duration(hours: 1)),
    title: 'Office',
    gradientColorIndex: 0,
  ),
  AlarmInfo(
    id: 2,
    alarmDateTime: DateTime.now().add(const Duration(hours: 2)),
    title: 'Sport',
    gradientColorIndex: 1,
  ),
];
