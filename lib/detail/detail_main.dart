import 'dart:convert';
import 'package:weather_app/data/data_main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class DetailWeatherLocation extends StatefulWidget {
  @override
  State<DetailWeatherLocation> createState() => _DetailWeatherLocationState();
}

class _DetailWeatherLocationState extends State<DetailWeatherLocation> {
  // const DetailWeatherLocation({super.key});
  String location = "";

  Map data = {};
  bool loaded = false;
  List allDetailLocation = [];
  int isDay = 1;

  void loadDaysData({days=7}) async{
    try {
      Response response = await get(Uri.parse("http://api.weatherapi.com/v1/forecast.json?key=fe26cfcaf9d04f55896112751251502&q=$location&days=$days&aqi=no&alerts=no"));
      Map daysData = jsonDecode(response.body);
      daysData["forecast"]["forecastday"].forEach((one) async {
        Location newLocation = Location(location: location);
        newLocation.setData(one);
        allDetailLocation.add(newLocation);
      });
      setState(() {
        loaded = true;
      });
    } catch (e){
      Navigator.pushNamed(context, "/network_error", arguments: {
          "back_path_name": "/loading",
          "backup_function": loadDaysData
        });
    }
    
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!data.isNotEmpty){
      data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;
      location = data["location"];
      isDay = data["is_day"];
      try {
        loadDaysData();
      } catch (e){
        Navigator.pushNamed(context, "/network_error", arguments: {
          "back_path_name": "/loading",
          "backup_function": loadDaysData
        });
      }
    }

    Color contentColor = isDay == 1 ? Colors.black : Colors.white;

    initializeDateFormatting("cs", null);
    

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDay == 1 ? Colors.white : const Color.fromARGB(255, 10, 51, 123),
        leading: BackButton(
          color: contentColor,
        ),
      ),
      backgroundColor: isDay == 1 ? Colors.white : const Color.fromARGB(255, 10, 51, 123),
      body: !loaded ? SpinKitCircle(
        color: contentColor,
        size: 25,
      ) : Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: ListView.builder(
          itemCount: allDetailLocation.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                height: 75,
                child: Card(
                  color: isDay == 1 ? const Color.fromARGB(255, 232, 232, 232) : const Color.fromARGB(0, 255, 255, 255),
                  child: InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, "/detail_day", arguments: {
                        "is_day": isDay,
                        "data": allDetailLocation[index]
                      });
                    },
                    child: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                          DateFormat("MM/dd").format(allDetailLocation[index].dateInf),
                          style: TextStyle(
                              color: contentColor
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            child: Text(
                              [0, 1].contains(index) ? index == 0 ? "Today" : "Tomorrow" : DateFormat("EEE", "en").format(allDetailLocation[index].dateInf),
                              style: TextStyle(
                                color: contentColor
                              ),
                              )
                            ),
                          Image.network(
                            "https:${allDetailLocation[index].pathImage}",
                            height: 40,
                            ),
                          SizedBox(
                            width: 80,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "${allDetailLocation[index].minTemperature}°/${allDetailLocation[index].maxTemperature}°",
                                style: TextStyle(
                                  color: contentColor
                                ),
                              ),
                            ),
                          )
                          ]
                      ),
                    ),
                  ),
                  ),
              ),
            );
          },
          ),
      ),
    );
  }
}