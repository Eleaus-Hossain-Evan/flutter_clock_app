import 'package:flutter/foundation.dart';
import 'package:flutter_easylogger/flutter_logger.dart';

import '../alram_helper.dart';
import '../model/alarm_info.dart';

class LocalDatabaseProvider extends ChangeNotifier {
  final AlarmHelper _alarmHelper = AlarmHelper.instance;
  final List<AlarmInfo> _alarms = [];
  bool _loading = false;

  List<AlarmInfo> get alarms => _alarms;
  bool get loading => _loading;

  LocalDatabaseProvider() {
    getAllAlarms();
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void getAllAlarms() async {
    _alarms.clear();
    _alarms.addAll(await _alarmHelper.getAlarms());
    Logger.d(_alarms.length);
    setLoading(false);
  }

  void addAlarm(AlarmInfo alarmInfo) {
    _alarmHelper.insertAlarm(alarmInfo);
    getAllAlarms();
    // notifyListeners();
  }

  void deleteAlarm(int id) async {
    await _alarmHelper.delete(id);
    getAllAlarms();
    // notifyListeners();
  }
}
