import "package:flutter/material.dart";
import 'package:intl/intl.dart';

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
            Text(DateFormat("dd.MM.yyyy").format(informationDay.dateInf)),
            Text("${informationDay.minTemperature}°/${informationDay.maxTemperature}°"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      informationDay.sunrise,
                      style: TextStyle(
                        color: colorText
                      )),
                    Text(
                      "Sunrise"
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      informationDay.sunset,
                      style: TextStyle(
                        color: colorText
                      )
                      ),
                    Text(
                      "Sunset"
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 12,
                itemBuilder: (context, index){
                  return Card(
                    child: Text("dayyyyyy"),
                  );
                }),
            )
          ],
        ),
      ),
    );
  }
}