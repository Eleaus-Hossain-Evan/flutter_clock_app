import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'model/alarm_info.dart';

const String tableAlarm = 'alarm';
const String columnId = 'id';
const String columnTitle = 'title';
const String columnDateTime = 'alarmDateTime';
const String columnPending = 'isPending';
const String columnColorIndex = 'gradientColorIndex';

class AlarmHelper {
  static Database? _database;
  AlarmHelper._();

  static final instance = AlarmHelper._();
  // factory AlarmHelper() {
  //   if (_alarmHelper == null) {
  //     _alarmHelper = AlarmHelper._createInstance();
  //   }
  //   return _alarmHelper;
  // }

  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = "${dir}alarm.db";

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          create table $tableAlarm (
          $columnId integer primary key autoincrement,
          $columnTitle text not null,
          $columnDateTime text not null,
          $columnPending integer,
          $columnColorIndex integer)
        ''');
      },
    );
    return database;
  }

  void insertAlarm(AlarmInfo alarmInfo) async {
    var db = await database;
    var result = await db.insert(tableAlarm, alarmInfo.toMap());
    print('result : $result');
  }

  Future<List<AlarmInfo>> getAlarms() async {
    List<AlarmInfo> alarms = [];

    var db = await database;
    var result = await db.query(tableAlarm);
    for (var element in result) {
      var alarmInfo = AlarmInfo.fromMap(element);
      alarms.add(alarmInfo);
    }

    return alarms;
  }

  Future<int> delete(int id) async {
    var db = await database;
    return await db.delete(tableAlarm, where: '$columnId = ?', whereArgs: [id]);
  }
}
