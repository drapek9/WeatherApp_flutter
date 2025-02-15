import 'package:flutter/material.dart';

class DetailWeatherLocation extends StatelessWidget {
  const DetailWeatherLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          return Card(
            child: Text(
              "Hello"
              ),
            );
        },
        ),
    );
  }
}