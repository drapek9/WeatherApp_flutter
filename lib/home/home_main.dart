import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/data/data_main.dart';
import 'package:weather_app/structure_widgets/structure_widgets_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Map data = {};
  dynamic infLocation;
  String hello = "ahoj";

  Future<void> setShared () async{
    SharedPreferences theShared = await SharedPreferences.getInstance();
    await theShared.setString("location", infLocation.location);
  }

  void changeLocation(newValue) async {
    setState(() {
      infLocation = newValue;
    });
    
    await setShared();
  }

  @override
  Widget build(BuildContext context) {
    if (!data.isNotEmpty){
      data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;
      infLocation = data["first_location"];
    }

    Color textColor = infLocation.isDay == 1 ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: infLocation.isDay == 1 ? Colors.white : const Color.fromARGB(255, 10, 51, 123),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.only(right: 30),
                  child: Text(
                    "Last update: ${DateFormat("HH:mm:ss dd.MM.yyyy").format(DateTime.parse(infLocation.lastUpdate))}",
                    style: TextStyle(
                      fontSize: 10,
                      color: textColor
                    ),
                    
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, "/choose_location", arguments: {
                    "current_location": changeLocation
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: infLocation.isDay == 1 ? Colors.black : const Color.fromARGB(0, 255, 255, 255)
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
                  fontSize: 20,
                  color: textColor
                ),
                ),
              SizedBox(
                height: 15,
              ),
              Image.network("https:${infLocation.pathImage}"),
              Text(
                infLocation.statusName,
                style: TextStyle(
                  color: textColor
                ),),
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
                      fontWeight: FontWeight.bold,
                      color: textColor
                    ),
                    ),
                  Text(
                    "${infLocation.feelTemperature} °C",
                    style: TextStyle(
                      fontSize: 20,
                      color: textColor
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
                  BottomInf(topInf: "${infLocation.humidity} %", bottomInf: "Humidity", textColor: textColor,),
                  BottomInf(topInf: "${infLocation.windSpeed} km/h", bottomInf: "Wind speed", textColor: textColor),
                  BottomInf(topInf: "${infLocation.uvIndex} UV", bottomInf: "UV index", textColor: textColor),
                ],
              ),
              Expanded(
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: infLocation.isDay == 1 ? Colors.black : const Color.fromARGB(0, 255, 255, 255)
                    ),
                    onPressed: (){
                      Navigator.pushNamed(context, "/detail", arguments: {
                        "location": infLocation.location,
                        "is_day": infLocation.isDay
                      });
                    },
                    child: Text(
                      "Detail information",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    )),
                ),
              ),
              Expanded(
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 235, 235, 235)
                    ),
                    onPressed: () async{
                      Location newLocation = Location(location: infLocation.location);
                      await newLocation.getData();
                      setState(() {
                        infLocation = newLocation;
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Refresh",
                          style: TextStyle(
                            color: Colors.black
                          ),
                          ),
                        SizedBox(width: 8,),
                        Icon(
                          Icons.refresh,
                          color: Colors.black
                          )
                      ],
                    )),
                ),
              )
            ],
          ),
        )
        ),
    );
  }
}