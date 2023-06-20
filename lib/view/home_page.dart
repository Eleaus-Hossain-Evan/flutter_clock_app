import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import '../model/menu_info.dart';
import '../constants/theme_data.dart';

import 'clock_page.dart';
import 'alarm_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _pages = [
    ClockPage(),
    AlarmPage(),
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.green,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2F41),
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems.map((e) => buildMenuButton(e)).toList(),
          ),
          const VerticalDivider(
            color: Colors.white54,
            width: 1,
          ),
          Consumer<MenuInfo>(
            builder: (context, value, child) {
              return Expanded(child: _pages[value.menuType.index]);
            },
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: TextButton(
            style: ButtonStyle(
              // padding: MaterialStateProperty.all<EdgeInsets>(
              //     const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
              backgroundColor: MaterialStateProperty.all<Color>(
                  currentMenuInfo.menuType == value.menuType
                      ? CustomColors.menuBackgroundColor
                      : Colors.transparent),
              // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //   RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              // ),
            ),
            onPressed: () {
              var menuInfo = Provider.of<MenuInfo>(context, listen: false);

              menuInfo.updateMenuInfo(currentMenuInfo);
            },
            child: Column(
              children: [
                Image.asset(
                  currentMenuInfo.imageSource,
                  scale: 1.5,
                ),
                const SizedBox(height: 16),
                Text(
                  currentMenuInfo.title,
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
      },
    );
  }
}
