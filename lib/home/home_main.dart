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
                    inf_location.temperature.toString() + "°C",
                    style: TextStyle(
                      fontSize: 50
                    ),
                    ),
                  Text(
                    inf_location.feel_temperature.toString() + "°C",
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    inf_location.humidity.toString() + " %"
                  ),
                  Text(
                    inf_location.wind_speed.toString() + " m/s"
                  ),
                  Text(
                    inf_location.uv_index.toString() + " UV"
                  )
                ],
              )
            ],
          ),
        )
        ),
    );
  }
}