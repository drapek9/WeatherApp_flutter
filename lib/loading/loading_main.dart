import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/data/data_main.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void loadInformation() async {
    Location startLocation = Location(location: "San Francisco");
    await startLocation.getData();
    // await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, "/home", arguments: {
      "first_location": startLocation
    });
  }

  @override
  void initState() {
    super.initState();
    loadInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitCircle(
          color: Colors.white,
          size: 25.0,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Loading",
          style: TextStyle(
            decoration: TextDecoration.none,
            color: Colors.white,
            fontSize: 14
          ),
        ),
      ],
    );
  }
}