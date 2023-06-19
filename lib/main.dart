import 'package:flutter/material.dart';
import 'package:flutter_clock_app/enums.dart';
import 'package:flutter_clock_app/view/home_page.dart';
import 'package:flutter_clock_app/model/menu_info.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider<MenuInfo>(
        create: (context) => MenuInfo(MenuType.clock,
            title: "Clock", imageSource: "assets/clock_icon.png"),
        child: const HomePage(),
      ),
    );
  }
}
