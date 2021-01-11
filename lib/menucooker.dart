import 'package:flutter/material.dart';
import 'package:homecook/addmyservices.dart';
import 'package:homecook/anotherservices.dart';
import 'package:homecook/myseconddishes.dart';
import 'package:homecook/myservices.dart';
import 'package:homecook/PrivacyPolicy.dart';
import './services/CookerService.dart';
import './cookermsg.dart';
import './subscriptioncooker.dart';
import './loginas.dart';

class Menucooker extends StatefulWidget {
  @override
  _MenucookerState createState() => _MenucookerState();
}

bool isSwitched = false;

class _MenucookerState extends State<Menucooker> {
  changestate() async {
    Map<String, dynamic> data = {'online': isSwitched};
    var response = await CookerService().setstate(data);
  }

  @override
  void initState() {
    getcooker();
    super.initState();
  }

  var cooker;
  getcooker() async {
    var response = await CookerService().getcooker();
    if (mounted) {
      setState(() {
        cooker = response;
      });
    }
    print(cooker);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          shrinkWrap: true,
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                  child: Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/user.png'),
                          fit: BoxFit.cover,
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  cooker != null
                      ? Text(cooker['name'] != null ? cooker['name'] : "",
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))
                      : Center(
                          child: SizedBox(
                            child: CircularProgressIndicator(),
                            height: 20.0,
                            width: 20.0,
                          ),
                        ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'الظهور على الخريطة ',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                              print(isSwitched);
                              changestate();
                            });
                          },
                          // activeTrackColor: Colors.greenAccent[400],
                          activeColor: Colors.blueAccent[700],
                        ),
                      ],
                    ),
                  )
                ],
              )),
              decoration: BoxDecoration(
                color: Color(0xFF153e90),
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.home, size: 20, color: Color(0xFF153e90)),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('أطباقي',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF153e90))),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Myservices()));
              },
            ),
            Divider(
              color: Color(0xFF153e90),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.food_bank, size: 20, color: Color(0xFF153e90)),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('أطباقي الجانبية',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF153e90))),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => Myseconddishes()));
              },
            ),
            Divider(
              color: Color(0xFF153e90),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.add_circle, size: 20, color: Color(0xFF153e90)),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('اضافة طبق رئيسي',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF153e90))),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => Addmyservices()));
              },
            ),
            Divider(
              color: Color(0xFF153e90),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.add_circle, size: 20, color: Color(0xFF153e90)),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('اضافة طبق جانبي',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF153e90))),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => Anotherservices()));
              },
            ),
            Divider(
              color: Color(0xFF153e90),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.message, size: 20, color: Color(0xFF153e90)),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('الرسائل',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF153e90))),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Cookermsg()));
              },
            ),
            Divider(
              color: Color(0xFF153e90),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.food_bank, size: 20, color: Color(0xFF153e90)),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('الطلبات',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF153e90))),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => CookerSubscription()));
              },
            ),
            Divider(
              color: Color(0xFF153e90),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.file_copy_rounded,
                      size: 20, color: Color(0xFF153e90)),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('الشروط والأحكام',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF153e90))),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => PrivacyPolicy()));
              },
            ),
            Divider(
              color: Color(0xFF153e90),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.logout, size: 20, color: Color(0xFF153e90)),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('تسجيل الخروج ',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF153e90))),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => Loginas(),
                  ),
                  (route) => false,
                );
              },
            ),
            Divider(
              color: Color(0xFF153e90),
            ),
          ],
        ),
      ),
    );
  }
}
