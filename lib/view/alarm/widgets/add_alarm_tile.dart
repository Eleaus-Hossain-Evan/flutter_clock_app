import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_app/extensions/extensions.dart';
import 'package:flutter_clock_app/providers/local_database_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;

import '../../../constants/theme_data.dart';
import '../../../main.dart';
import '../../../model/alarm_info.dart';

class AddAlarmTile extends StatelessWidget {
  const AddAlarmTile({super.key});

  @override
  Widget build(BuildContext context) {
    bool isRepeatSelected = false;
    return DottedBorder(
      strokeWidth: 2,
      color: CustomColors.clockOutline,
      borderType: BorderType.RRect,
      radius: const Radius.circular(24),
      dashPattern: [5, 4],
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: CustomColors.clockBG,
          borderRadius: const BorderRadius.all(Radius.circular(24)),
        ),
        child: TextButton(
          onPressed: () {
            String alarmTimeString = DateTime.now().toHHMM();
            showModalBottomSheet(
              useRootNavigator: true,
              context: context,
              clipBehavior: Clip.antiAlias,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              builder: (context) {
                DateTime alarmTime = DateTime.now();
                return StatefulBuilder(
                  builder: (context, setModalState) {
                    return Container(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        children: [
                          FilledButton(
                            onPressed: () async {
                              var selectedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (selectedTime != null) {
                                final now = DateTime.now();
                                var selectedDateTime = DateTime(
                                    now.year,
                                    now.month,
                                    now.day,
                                    selectedTime.hour,
                                    selectedTime.minute);
                                alarmTime = selectedDateTime;
                                setModalState(() {
                                  alarmTimeString = selectedDateTime.toHHMM();
                                });
                              }
                            },
                            child: Text(
                              alarmTimeString,
                              style: const TextStyle(fontSize: 32),
                            ),
                          ),
                          ListTile(
                            title: const Text('Repeat'),
                            trailing: Switch(
                              onChanged: (value) {
                                setModalState(() {
                                  isRepeatSelected = value;
                                });
                              },
                              value: isRepeatSelected,
                            ),
                          ),
                          const ListTile(
                            title: Text('Sound'),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                          const ListTile(
                            title: Text('Title'),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                          FloatingActionButton.extended(
                            onPressed: () {
                              onSaveAlarm(
                                context,
                                isRepeating: isRepeatSelected,
                                alarmTime: alarmTime,
                              );
                            },
                            icon: const Icon(Icons.alarm),
                            label: const Text('Save'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
            // scheduleAlarm();
          },
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/add_alarm.png',
                scale: 1.5,
              ),
              const SizedBox(height: 8),
              const Text(
                'Add Alarm',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'avenir',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void scheduleAlarm(
      DateTime scheduledNotificationDateTime, AlarmInfo alarmInfo,
      {bool isRepeating = true}) async {
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();

    tzData.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      channelDescription: 'Channel for Alarm notification',
      icon: 'codex_logo',
      // sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
        sound: 'a_long_cold_sting.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    if (isRepeating) {
      await flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        alarmInfo.title,
        alarmInfo.title,
        RepeatInterval.daily,
        platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    } else {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        alarmInfo.title,
        alarmInfo.title,
        tz.TZDateTime.now(tz.local).add(
          Duration(
            seconds: scheduledNotificationDateTime.second,
            minutes: scheduledNotificationDateTime.minute,
            hours: scheduledNotificationDateTime.hour,
            // days: scheduledNotificationDateTime.day,
          ),
        ),
        platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  void onSaveAlarm(
    BuildContext context, {
    bool isRepeating = false,
    required DateTime alarmTime,
  }) {
    final local = context.read<LocalDatabaseProvider>();
    DateTime scheduleAlarmDateTime;
    if (alarmTime.isAfter(DateTime.now())) {
      scheduleAlarmDateTime = alarmTime;
    } else {
      scheduleAlarmDateTime = alarmTime.add(const Duration(days: 1));
    }

    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: local.alarms.length,
      title: 'alarm',
    );
    local.addAlarm(alarmInfo);
    scheduleAlarm(scheduleAlarmDateTime, alarmInfo, isRepeating: isRepeating);
    Navigator.pop(context);
  }
}
