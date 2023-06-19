import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_app/data.dart';

import '../constants/theme_data.dart';

class AlarmPage extends StatelessWidget {
  const AlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Alarm',
            style: TextStyle(
              fontFamily: 'avenir',
              fontWeight: FontWeight.w700,
              color: CustomColors.primaryTextColor,
              fontSize: 24,
            ),
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: alarms
                  .map<Widget>(
                (alarm) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  margin: const EdgeInsets.only(bottom: 32),
                  decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(24),
                    ),
                    gradient: LinearGradient(
                      colors: alarm.gradientColors,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: alarm.gradientColors.last.withOpacity(.4),
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: const Offset(4, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.label,
                            color: CustomColors.primaryTextColor,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            alarm.description ?? '',
                            style: TextStyle(
                                color: CustomColors.primaryTextColor,
                                fontFamily: 'avenir'),
                          ),
                          Flexible(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Switch(
                                value: true,
                                onChanged: (val) {},
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Mon-Fri',
                        style: TextStyle(
                          fontFamily: 'avenir',
                          color: CustomColors.primaryTextColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '07:00 AM',
                            style: TextStyle(
                              fontFamily: 'avenir',
                              color: CustomColors.primaryTextColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 30,
                            color: CustomColors.primaryTextColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
                  .followedBy([
                DottedBorder(
                  strokeWidth: 1,
                  color: CustomColors.clockOutline,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(24),
                  dashPattern: [5, 4],
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: CustomColors.clockBG,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Column(
                        children: [
                          Image.asset("assets/add_alarm.png", scale: 1.5),
                          const SizedBox(height: 8),
                          Text(
                            'Add Alarm',
                            style: TextStyle(
                              fontFamily: 'avenir',
                              color: CustomColors.primaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
