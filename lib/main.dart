import 'package:flutter/material.dart';
import 'package:homecook/app.dart';
import 'package:homecook/conversation.dart';
import 'package:homecook/services/geolocater_service.dart';
import 'package:provider/provider.dart';
import './providers/cardItem.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final locatorService = GeolocaterService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          FutureProvider(create: (context) => locatorService.getlocation()),
          ChangeNotifierProvider<CartItem>(
            create: (context) => CartItem(),
          ),
        ],
        child: MaterialApp(
          supportedLocales: [Locale('en', 'US'), Locale('ar', 'SA')],
          home: App(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
