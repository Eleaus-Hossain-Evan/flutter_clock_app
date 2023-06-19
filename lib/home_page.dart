import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clock_app/clock_view.dart';
import 'package:intl/intl.dart';

import 'theme_data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();

    var formattedDate = DateFormat("EEE, d MMM").format(now);
    var timezoneString = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';
    if (!timezoneString.startsWith('-')) offsetSign = '+';
    print(timezoneString);

    return Scaffold(
      backgroundColor: const Color(0xFF2D2F41),
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildMenuButton(text: "Clock", iconPath: 'assets/clock_icon.png'),
              buildMenuButton(text: "Alarm", iconPath: 'assets/alarm_icon.png'),
              buildMenuButton(text: "Timer", iconPath: 'assets/timer_icon.png'),
              buildMenuButton(
                  text: "Stopwatch", iconPath: 'assets/stopwatch_icon.png'),
            ],
          ),
          const VerticalDivider(
            color: Colors.white54,
            width: 1,
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Text(
                    'Clock',
                    style: TextStyle(
                        fontFamily: 'avenir',
                        fontWeight: FontWeight.w700,
                        color: CustomColors.primaryTextColor,
                        fontSize: 24),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const DigitalClockWidget(),
                      Text(
                        formattedDate,
                        style: TextStyle(
                            fontFamily: 'avenir',
                            fontWeight: FontWeight.w300,
                            color: CustomColors.primaryTextColor,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: Align(
                    alignment: Alignment.center,
                    child: ClockView(
                      size: MediaQuery.of(context).size.height / 4,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Timezone',
                        style: TextStyle(
                            fontFamily: 'avenir',
                            fontWeight: FontWeight.w500,
                            color: CustomColors.primaryTextColor,
                            fontSize: 24),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.language,
                            color: CustomColors.primaryTextColor,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'UTC' + offsetSign + timezoneString,
                            style: TextStyle(
                                fontFamily: 'avenir',
                                color: CustomColors.primaryTextColor,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget buildMenuButton({required String text, required String iconPath}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: TextButton(
        onPressed: () {},
        child: Column(
          children: [
            Image.asset(
              iconPath,
              scale: 1.5,
            ),
            const SizedBox(height: 16),
            Text(
              text,
              style: const TextStyle(
                fontFamily: 'avenir',
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: .8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DigitalClockWidget extends StatefulWidget {
  const DigitalClockWidget({
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return DigitalClockWidgetState();
  }
}

class DigitalClockWidgetState extends State<DigitalClockWidget> {
  var formattedTime = DateFormat('HH:mm').format(DateTime.now());
  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      var perviousMinute =
          DateTime.now().add(const Duration(seconds: -1)).minute;
      var currentMinute = DateTime.now().minute;
      if (perviousMinute != currentMinute) {
        setState(() {
          formattedTime = DateFormat('HH:mm').format(DateTime.now());
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('=====>digital clock updated');
    return Text(
      formattedTime,
      style: TextStyle(
          fontFamily: 'avenir',
          color: CustomColors.primaryTextColor,
          fontSize: 64),
    );
  }
}
