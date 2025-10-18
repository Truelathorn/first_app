import 'package:first_app/constant/theme_data.dart';
import 'package:first_app/custom_widget.dart';
import 'package:first_app/setting_page.dart';
import 'package:first_app/traffic_light_screen.dart';
import 'package:flutter/material.dart';
// import ธีมที่คุณสร้างไว้

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false; // ตัวสลับธีม

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: TrafficApp()
    );
  }
}
