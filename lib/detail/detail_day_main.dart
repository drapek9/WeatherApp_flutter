import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:weather_app/structure_widgets/structure_widgets_main.dart';

class DetailDay extends StatelessWidget {
  // const DetailDay({super.key});

  @override
  Widget build(BuildContext context) {

    Map data = ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;
    int isDay = data["is_day"];
    dynamic informationDay = data["data"];
    Color colorText = isDay == 1 ? Colors.black : Colors.white;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDay == 1 ? Colors.white : const Color.fromARGB(255, 10, 51, 123),
        leading: BackButton(
          color: colorText,
        ),
      ),
      backgroundColor: isDay == 1 ? Colors.white : const Color.fromARGB(255, 10, 51, 123),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              DateFormat("dd.MM.yyyy").format(informationDay.dateInf),
              style: TextStyle(
                fontSize: 18,
                color: colorText
              )),
            SizedBox(
              height: 15,
            ),
            Text(
              informationDay.location,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: colorText
              ),
            ),
            SizedBox(height: 15,),
            Image.network("https:${informationDay.pathImage}"),
            SizedBox(
              height: 10,
            ),
            Text(
              "${informationDay.minTemperature}°/${informationDay.maxTemperature}°",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: colorText
              ),
              ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BottomInf(topInf: DateFormat("HH:mm").format(informationDay.sunrise) , bottomInf: "Sunrise", textColor: colorText),
                BottomInf(topInf: DateFormat("HH:mm").format(informationDay.sunset), bottomInf: "Sunset", textColor: colorText)
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Center(child: BottomInf(topInf: "${informationDay.humidity} %", bottomInf: "Avg. humidity", textColor: colorText))
                  ),
                Expanded(
                  child: Center(child: BottomInf(topInf: "${informationDay.maxWindKph} km/h", bottomInf: "Max wind", textColor: colorText))
                  ),
                Expanded(
                  child: Center(child: BottomInf(topInf: "${informationDay.uvIndex} UV", bottomInf: "UV index", textColor: colorText))
                  ),
              ],
            ),
            Expanded(
              child: Center(
                child: SizedBox(
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      // color: const Color.fromARGB(172, 0, 0, 0),
                      color: isDay == 1 ? const Color.fromARGB(255, 232, 232, 232) : const Color.fromARGB(0, 255, 255, 255),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: informationDay.hoursInf.length,
                          itemBuilder: (context, index){
                            Map theHour = informationDay.hoursInf[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 2.5),
                              child: HourContent(theHour: theHour, colorText: colorText,)
                            );
                          }),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HourContent extends StatelessWidget {
  // const HourContent({super.key});

  Map theHour = {};
  Color colorText = Colors.black;

  HourContent({required this.theHour, required this.colorText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
              width: 90,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      theHour["time"].split(" ")[1],
                      style: TextStyle(
                        fontSize: 13,
                        color: colorText
                      ),
                      ),
                    Image.network(
                      height: 35,
                      "https:${theHour["condition"]["icon"]}"
                      ),
                    Text(
                      "${theHour["temp_c"]}°",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorText
                      ),
                    ),
                  ],
                ),
              ),
            );
  }
}

class SunInf extends StatelessWidget {
  // const SunInf({super.key});

  String infTime = "";
  String description = "";
  Color colorText = Colors.red;

  SunInf({required this.infTime, required this.description, required this.colorText});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Text(
            infTime,
            style: TextStyle(
              color: colorText,
              fontWeight: FontWeight.bold,
              fontSize: 16
            )
            ),
          Text(
            description,
            style: TextStyle(
              color: colorText
            ),
          )
        ],
      );
  }
}