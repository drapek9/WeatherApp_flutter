import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

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