import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

Future<Map> getCurrentLocation() async{
  await Geolocator.requestPermission();
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.whileInUse){
      Position result = await Geolocator.getCurrentPosition();
      List splited_inf = result.toString().split(" ");
      Response res = await get(Uri.parse("http://api.weatherapi.com/v1/current.json?key=fe26cfcaf9d04f55896112751251502&q=${splited_inf[1]}${splited_inf[3]}&aqi=no"));
      // Map data = jsonDecode(res.body)["location"]["name"];
      Map data = jsonDecode(res.body);
      return data;
    }
    return {"result": "nothing"};

}