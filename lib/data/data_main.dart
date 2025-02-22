import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
class Location {
    String location;

    Location({required this.location});

    double? temperature;
    double? minTemperature;
    double? maxTemperature;
    double? feelTemperature;
    int? humidity;
    double? windSpeed;
    int? uvIndex;
    String? pathImage;
    String? statusName;
    int? isDay;
    String? lastUpdate;
    DateTime? dateInf;
    List hoursInf = [];
    DateTime? sunrise;
    DateTime? sunset;
    double? maxWindKph;

    Future<bool> getData() async {
        try {
          final Response response = await get(Uri.parse("https://www.google.com"));
        } catch (e){
          return false;
        }
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
        sunset = DateFormat("hh:mm a").parse(theData["astro"]["sunset"]);
        sunrise = DateFormat("hh:mm a").parse(theData["astro"]["sunrise"]);
        dateInf = DateTime.parse(theData["date"]);
        maxWindKph = theData["day"]["maxwind_kph"];
    }
}