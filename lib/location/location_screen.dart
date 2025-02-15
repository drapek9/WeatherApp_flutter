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
  
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;
    Function(Location) theLocation = data["current_location"];
    return Scaffold(
      appBar: AppBar(),
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
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 201, 201, 201),
                    border: InputBorder.none,
                  ),
                
                ),
              ),
              ElevatedButton(
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
                    color: Colors.black
                  ),
                )),
              optionLocation ? ElevatedButton(
                onPressed: (){
                  theLocation(newLocation);
                  // setState(() {
                  //   data["current_location"] = newLocation;
                  // });
                },
                child: Text("Select location")) : Text("")
            ],
          ),
        ),
      ),
    );
  }
}