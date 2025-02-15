import 'dart:convert';
import 'package:http/http.dart';
class Location {
    String location;

    Location({required this.location});

    double temperature = 0;
    double feel_temperature = 0;
    int humidity = 0;
    double wind_speed = 0;
    double uv_index = 0;

    void get_data() async {
        Response data = await get(Uri.parse("http://api.weatherapi.com/v1/current.json?key=fe26cfcaf9d04f55896112751251502&q=$location&aqi=no"));
        Map data_body = jsonDecode(data.body)["current"];
        temperature = data_body["temp_c"];
        feel_temperature = data_body["feelslike_c"];
        humidity = data_body["humidity"];
        wind_speed = data_body["gust_mph"];
        uv_index = data_body["uv"];
    }
}