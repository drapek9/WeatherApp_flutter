import 'package:flutter/material.dart';
import 'package:weather_app/data/data_main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;
    Location inf_location = data["first_location"];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black
                ),
                child: Text(
                  "Location",
                  style: TextStyle(
                    color: Colors.white
                  ),
                )
                ),
                
              SizedBox(
                height: 50,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    inf_location.temperature.toString() + " °C",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                  Text(
                    inf_location.feel_temperature.toString() + " °C",
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BottomInf(top_inf: inf_location.humidity.toString() + " %", bottom_inf: "Humidity"),
                  BottomInf(top_inf: inf_location.wind_speed.toString() + " km/h", bottom_inf: "Wind speed"),
                  BottomInf(top_inf: inf_location.uv_index.toString() + " UV", bottom_inf: "UV index"),
                ],
              )
            ],
          ),
        )
        ),
    );
  }
}

class BottomInf extends StatefulWidget {
  // const BottomInf({super.key});
  final String top_inf;
  final String bottom_inf;

  BottomInf({required this.top_inf, required this.bottom_inf});

  @override
  State<BottomInf> createState() => _BottomInfState();
}

class _BottomInfState extends State<BottomInf> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.top_inf,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
        Text(
          widget.bottom_inf,
          style: TextStyle(
            fontSize: 13
          ),
        )
      ],
    );
  }
}