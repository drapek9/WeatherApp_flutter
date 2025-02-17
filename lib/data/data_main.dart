import 'dart:convert';
import 'package:http/http.dart';
class Location {
    String location;

    Location({required this.location});

    double temperature = 0;
    double minTemperature = 0;
    double maxTemperature = 0;
    double feelTemperature = 0;
    int humidity = 0;
    double windSpeed = 0;
    int uvIndex = 0;
    String pathImage = "";
    String statusName = "";
    int isDay = 1;
    String lastUpdate = "";
    DateTime dateInf = DateTime(2024);
    List hoursInf = [];
    String sunrise = "";
    String sunset = "";
    double maxWindKph = 0;

    Future<bool> getData() async {
        Response data = await get(Uri.parse("http://api.weatherapi.com/v1/current.json?key=fe26cfcaf9d04f55896112751251502&q=$location&aqi=no"));
        if (!jsonDecode(data.body).keys.contains("error")){
            Map dataBody = jsonDecode(data.body)["current"];
            temperature = dataBody["temp_c"];
            feelTemperature = dataBody["feelslike_c"];
            humidity = dataBody["humidity"];
            windSpeed = dataBody["gust_kph"];
            uvIndex = (dataBody["uv"]*10).round();
            pathImage = dataBody["condition"]["icon"];
            statusName = dataBody["condition"]["text"];
            isDay = dataBody["is_day"];
            lastUpdate = dataBody["last_updated"];
            return true;
        }
        return false;
        
    }

    void setData(theData) {
        maxTemperature = theData["day"]["maxtemp_c"];
        minTemperature = theData["day"]["mintemp_c"];
        temperature = theData["day"]["avgtemp_c"];
        // feelTemperature = theData["feelslike_c"];
        humidity = theData["day"]["avghumidity"];
        uvIndex = (theData["day"]["uv"]*10).round();
        pathImage = theData["day"]["condition"]["icon"];
        statusName = theData["day"]["condition"]["text"];
        hoursInf = theData["hour"];
        sunset = theData["astro"]["sunset"];
        sunrise = theData["astro"]["sunrise"];
        dateInf = DateTime.parse(theData["date"]);
        maxWindKph = theData["day"]["maxwind_kph"];
    }
}