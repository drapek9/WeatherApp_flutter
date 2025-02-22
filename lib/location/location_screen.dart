import 'package:flutter/material.dart';
import 'package:weather_app/data/data_main.dart';
import 'package:weather_app/location/location_script.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LocationScreenChooser extends StatefulWidget {
  const LocationScreenChooser({super.key});

  @override
  State<LocationScreenChooser> createState() => _LocationScreenChooserState();
}

class _LocationScreenChooserState extends State<LocationScreenChooser> {
  TextEditingController myController = TextEditingController();
  bool optionLocation = false;
  Map data = {};
  dynamic newLocation;
  String lastLocationText = "";
  int? isDay;
  bool waitingCurLocation = false;
  
  @override
  Widget build(BuildContext context) {

    myController.addListener((){
      if (myController.text != lastLocationText){
        setState(() {
          optionLocation = false;
        });
      }
      lastLocationText = myController.text;
      
      
    });
    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;
    Function(Location) theLocation = data["current_location"];
    if (isDay == null){
      isDay = data["old_information"].isDay;
    }
    
    return Scaffold(
      backgroundColor: isDay == 1 ? Colors.white : const Color.fromARGB(255, 10, 51, 123),
      appBar: AppBar(
        backgroundColor: isDay == 1 ? Colors.white : const Color.fromARGB(255, 10, 51, 123),
        leading: BackButton(
          color: isDay == 1 ? Colors.black : Colors.white,
          onPressed: (){
            Navigator.pop(context, "/home");
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextField(
                      enabled: !waitingCurLocation,
                      controller: myController,
                      maxLength: 25,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        counterText: "",
                        hintText: "City",
                        filled: true,
                        // fillColor: const Color.fromARGB(255, 201, 201, 201),
                        fillColor:  const Color.fromARGB(255, 240, 240, 240),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: !optionLocation ? Colors.blueGrey: Color.fromARGB(255, 21, 152, 29))
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: const Color.fromARGB(182, 96, 125, 139))
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30), // Zaoblení i pro "focused" stav
                          borderSide: BorderSide(color: !optionLocation ? Colors.black: Color.fromARGB(255, 21, 152, 29)), // Barva při focus
                        ),
                      ),
                    
                    ),
                  ),
                waitingCurLocation ? SpinKitCircle(
                color: isDay == 1 ? Colors.black : Colors.white,
                size: 25.0,
                ) : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: isDay == 1 ? const Color.fromARGB(255, 0, 0, 0) : Colors.white
                      backgroundColor: isDay == 1 ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(62, 0, 0, 0)
                    ),
                    onPressed: () async{
                      setState(() {
                      waitingCurLocation = true;
                      optionLocation = false;
                    });
                      Map data = await getCurrentLocation();
                      myController.text = data["location"]["name"];
                      setState(() {
                        waitingCurLocation = false;
                      });
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: isDay == 1 ? Colors.white : Colors.white,),
                        Text(
                          "Now",
                          style: TextStyle(
                            color: isDay == 1 ? Colors.white : Colors.white,
                            fontSize: 8
                          ),
                          )
                      ],
                    ))
                ],
              ),
              SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDay == 1 ? Colors.black : const Color.fromARGB(62, 0, 0, 0),
                  disabledBackgroundColor: isDay == 1 ? const Color.fromARGB(255, 223, 223, 223) : const Color.fromARGB(71, 0, 0, 0)
                ),
                onPressed: !waitingCurLocation ? () async{
                  Location searchedLocation = Location(location: myController.text);
                  bool response = await searchedLocation.getData();

                  setState(() {
                      optionLocation = response;
                      newLocation = searchedLocation;
                    });

                } : null,
                child: Text(
                  "Search",
                  style: TextStyle(
                    color: isDay == 1 ? Colors.white : Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                )),
              SizedBox(
                height: 10,
              ),
              optionLocation ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 21, 152, 29)
                ),
                onPressed: () async{
                  int dayReturn = await theLocation(newLocation);
                  setState(() {
                      optionLocation = false;
                      isDay = dayReturn;
                    });
                },
                child: Text(
                  "Select location",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                  )) : Text("")
            ],
          ),
        ),
      ),
    );
  }
}