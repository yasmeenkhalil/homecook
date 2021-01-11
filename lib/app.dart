import 'package:flutter/material.dart';
import 'package:homecook/services/geolocater_service.dart';
import 'package:homecook/splash/splash_screen.dart';

class App extends StatelessWidget {
  @override
  final locatorService = GeolocaterService();
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
          body: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => SplashScreen()));
        },
        child: Container(
            color: Colors.grey[200],
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Color(0xFF153e90)),
              child: Center(
                child: Text(
                  "ارحب",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                  ),
                ),
              ),
            )),
      )),
    );
  }
}
