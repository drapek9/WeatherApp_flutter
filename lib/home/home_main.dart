import 'package:flutter/material.dart';
import 'package:weather_app/data/data_main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Map data = {};
  dynamic infLocation;

  void changeLocation(newValue){
    setState(() {
      infLocation = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!data.isNotEmpty){
      data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;
      infLocation = data["first_location"];
    }
    

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, "/choose_location", arguments: {
                    "current_location": changeLocation
                  });
                },
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
              SizedBox(height: 30),
              Text(
                infLocation.location,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20
                ),
                ),
              SizedBox(
                height: 15,
              ),
              Image.network("https:${infLocation.pathImage}"),
              Text(infLocation.statusName),
              SizedBox(
                height: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${infLocation.temperature} °C",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                  Text(
                    "${infLocation.feelTemperature} °C",
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
                  BottomInf(top_inf: "${infLocation.humidity} %", bottom_inf: "Humidity"),
                  BottomInf(top_inf: "${infLocation.windSpeed} km/h", bottom_inf: "Wind speed"),
                  BottomInf(top_inf: "${infLocation.uvIndex} UV", bottom_inf: "UV index"),
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