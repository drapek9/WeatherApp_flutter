import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DetailWeatherLocation extends StatefulWidget {
  @override
  State<DetailWeatherLocation> createState() => _DetailWeatherLocationState();
}

class _DetailWeatherLocationState extends State<DetailWeatherLocation> {
  // const DetailWeatherLocation({super.key});
  String location = "";

  Map data = {};
  bool loaded = false;
  Map daysData = {};

  void loadDaysData({days=3}) async{
    Response response = await get(Uri.parse("http://api.weatherapi.com/v1/forecast.json?key=fe26cfcaf9d04f55896112751251502&q=$location&days=$days&aqi=no&alerts=no"));
    daysData = jsonDecode(response.body);
    setState(() {
      loaded = true;
    });
  }
  @override
  void initState() {
    super.initState();
    // loadDaysData();
  }

  @override
  Widget build(BuildContext context) {
    if (!data.isNotEmpty){
      data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;
      location = data["location"];
      loadDaysData();
    }
    

    return Scaffold(
      backgroundColor: Colors.white,
      body: !loaded ? SpinKitCircle(
        color: Colors.black,
        size: 25,
      ) : ListView.builder(
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