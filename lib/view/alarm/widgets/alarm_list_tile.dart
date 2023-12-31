import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/theme_data.dart';
import '../../../model/alarm_info.dart';
import '../../../extensions/extensions.dart';
import '../../../providers/local_database_provider.dart';

class AlarmListTile extends StatelessWidget {
  const AlarmListTile({
    Key? key,
    required this.alarm,
  }) : super(key: key);

  final AlarmInfo alarm;

  @override
  Widget build(BuildContext context) {
    final alarmTime = alarm.alarmDateTime.toHHMMAA();
    final gradientColor =
        GradientTemplate.gradientTemplate[alarm.gradientColorIndex].colors;
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColor,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColor.last.withOpacity(0.4),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(4, 4),
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Icon(
                    Icons.label,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    alarm.title,
                    style: const TextStyle(
                        color: Colors.white, fontFamily: 'avenir'),
                  ),
                ],
              ),
              Switch(
                onChanged: (bool value) {},
                value: true,
                activeColor: Colors.white,
              ),
            ],
          ),
          const Text(
            'Mon-Fri',
            style: TextStyle(color: Colors.white, fontFamily: 'avenir'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                alarmTime,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'avenir',
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.white,
                onPressed: () {
                  context.read<LocalDatabaseProvider>().deleteAlarm(alarm.id!);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
