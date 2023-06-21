import 'package:flutter/material.dart';
import 'package:flutter_clock_app/view/alarm/widgets/alarm_list_tile.dart';
import 'package:provider/provider.dart';

import '../../constants/theme_data.dart';
import '../../model/alarm_info.dart';
import '../../providers/local_database_provider.dart';
import 'widgets/add_alarm_tile.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  List<AlarmInfo> currentAlarms = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // context.read<LocalDatabaseProvider>().getAllAlarms();
      // currentAlarms = context.read<LocalDatabaseProvider>().alarms;
      // setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Alarm',
            style: TextStyle(
                fontFamily: 'avenir',
                fontWeight: FontWeight.w700,
                color: CustomColors.primaryTextColor,
                fontSize: 24),
          ),
          Expanded(
            child: Consumer<LocalDatabaseProvider>(
              builder: (context, value, child) {
                final currentAlarms = value.alarms;
                if (value.loading) {
                  return const Center(
                    child: Text(
                      'Loading...',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                return ListView(
                  physics: const BouncingScrollPhysics(),
                  children: currentAlarms
                      .map<Widget>((alarm) => AlarmListTile(alarm: alarm))
                      .followedBy([
                    if (currentAlarms.length < 5)
                      const AddAlarmTile()
                    else
                      const Center(
                        child: Text(
                          'Only 5 alarms allowed!',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                  ]).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
