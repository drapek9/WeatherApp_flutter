import 'package:flutter/material.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart';

class NetworkError extends StatefulWidget {
  const NetworkError({super.key});

  @override
  State<NetworkError> createState() => _NetworkErrorState();
}

class _NetworkErrorState extends State<NetworkError> {
  String errorText = "";
  void reloadButtonFunction() async{
      try {
        await get(Uri.parse("https://www.google.com"));
        Navigator.pop(context);
      } catch(e) {
        setState(() {
          errorText = "There is an error";
        });
        Future.delayed(Duration(seconds: 3), (){
          clearErrorText();
        });
      }
    }

  void clearErrorText() {
    setState(() {
      errorText = "";
    });
  }
  
  @override
  Widget build(BuildContext context) {

    Map data = ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;
    String backPathName = data["back_path_name"];

    return SafeArea(
      child: Expanded(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "No network connection",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  decoration: TextDecoration.none
                ),)
              ),
            SizedBox(height: 80,),
            ElevatedButton(
              onPressed: (){
                // zde bude funkce pro získání, zda připojen
                reloadButtonFunction();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: Text(
                "Reload",
                style: TextStyle(
                  color: Colors.black
                ),),
              ),
            SizedBox(
              height: 10,
            ),
            Text(
              errorText,
              style: TextStyle(
                color: Colors.red,
                fontSize: 15,
                decoration: TextDecoration.none
              ),
            )
          ],
        ),
      ),
    );
  }
}