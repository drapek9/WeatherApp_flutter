import 'package:flutter/material.dart';
import 'package:weather_app/loading/loading_main.dart';
import 'package:weather_app/home/home_main.dart';
import 'package:weather_app/location/location_screen.dart';
import 'package:weather_app/detail/detail_main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/loading",
      routes: {
        "/loading": (context) => LoadingScreen(),
        "/home": (context) => HomeScreen(),
        "/choose_location": (context) => LocationScreenChooser(),
        "/detail": (context) => DetailWeatherLocation()
      },
    );
  }
}
