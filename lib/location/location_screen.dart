import 'package:flutter/material.dart';
import 'package:weather_app/data/data_main.dart';

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
  String lastLocationText ="";
  
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
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
              SizedBox(
                width: 300,
                child: TextField(
                  controller: myController,
                  maxLength: 25,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: "City",
                    filled: true,
                    // fillColor: const Color.fromARGB(255, 201, 201, 201),
                    fillColor:  const Color.fromARGB(255, 240, 240, 240),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: !optionLocation ? Colors.blueGrey: Color.fromARGB(255, 21, 152, 29))
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30), // Zaoblení i pro "focused" stav
                      borderSide: BorderSide(color: !optionLocation ? Colors.black: Color.fromARGB(255, 21, 152, 29)), // Barva při focus
                    ),
                  ),
                
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 235, 235, 235)
                ),
                onPressed: () async{
                  Location searchedLocation = Location(location: myController.text);
                  bool response = await searchedLocation.getData();

                  setState(() {
                      optionLocation = response;
                      newLocation = searchedLocation;
                    });

                },
                child: Text(
                  "Search",
                  style: TextStyle(
                    color: Colors.black,
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
                onPressed: (){
                  theLocation(newLocation);
                  setState(() {
                    setState(() {
                      optionLocation = false;
                    });
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