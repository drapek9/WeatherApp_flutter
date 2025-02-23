import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weather_app/data/data_main.dart';
import 'package:weather_app/location/location_script.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List historyLocation = [];

  void addLocationHistory(locationName) async {
    SharedPreferences theShared = await SharedPreferences.getInstance();
    List sharedResult = jsonDecode(theShared.getString("location_history") ?? "[]");
    if (sharedResult.contains(locationName)){
      sharedResult.remove(locationName);
    }
    sharedResult.add(locationName);

    await theShared.setString("location_history", jsonEncode(sharedResult));

    setState(() {
      historyLocation = sharedResult;
    });
  }

  void getStartHistoryLocation() async {
    SharedPreferences theShared = await SharedPreferences.getInstance();
    
    setState(() {
      historyLocation = jsonDecode(theShared.getString("location_history") ?? "[]");
    });
  }

  @override
  void initState() {
    super.initState();
    getStartHistoryLocation();
  }

  void changeTextFieldText(theValue){
    setState(() {
      myController.text = theValue;
    });
  }
  
  @override
  Widget build(BuildContext context) {

    myController.addListener((){
      if (myController.text != lastLocationText){
        setState(() {
          optionLocation = false;
        });
        lastLocationText = myController.text;
      }
      
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
                  addLocationHistory(myController.text);
                },
                child: Text(
                  "Select location",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                  )) : Text(""),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 213, 213, 213)
                        ),
                        onPressed: (){
                          showBottomChooserHistory(context, historyLocation, changeTextFieldText);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 10,
                          children: [
                            Text(
                              "History",
                              style: TextStyle(
                                color: Colors.black
                              ),
                              ),
                            Icon(
                              Icons.history,
                              color: Colors.black,
                              ),
                          ],
                        )
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void showBottomChooserHistory (context, historyLocation, functionClicked){
  ScrollController scrollController = ScrollController();
  showModalBottomSheet(
    backgroundColor: const Color.fromARGB(255, 235, 235, 235),
    context: context,
    builder: (context) {
      return SizedBox(
        height: 400,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "History",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                  ),
                ),
            ),
            Divider(
              height: 1,
              color: const Color.fromARGB(255, 175, 175, 175),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ListView.builder(
                  controller: scrollController,
                  padding: EdgeInsets.only(top: 5),
                  itemCount: historyLocation.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                      child: Expanded(
                        child: Card(
                          color: Colors.white,
                          child: InkWell(
                            onTap: (){
                              functionClicked(historyLocation[index]);
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: Text(
                                  historyLocation[index],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                  ),
                                  ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        )
      );
    });
  WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
}