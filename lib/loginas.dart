import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:homecook/cookerregister.dart';
import 'package:homecook/loginascooker.dart';
import 'package:homecook/loginasuser.dart';
import 'package:homecook/userregister.dart';

class Loginas extends StatefulWidget {
  @override
  _LoginasState createState() => _LoginasState();
}

class _LoginasState extends State<Loginas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF153e90),
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
          child: Container(),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60)),
                color: Colors.white,
              ),
              child: Center(
                  child: Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Text(
                    "اهلا بك في المطبخ المنزلي ",
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  ),
                  Text(
                    "تسجيل الدخول ",
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  ),
                ],
              )),
            ),
            SizedBox(
              height: 120,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => Loginascooker()));
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Color(0xFF153e90),
                  border: Border.all(color: Colors.blue),
                ),
                child: Center(
                  child: Text(
                    ' دخول كطباخ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Loginasuser()));
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Color(0xFF153e90),
                  border: Border.all(color: Colors.blue),
                ),
                child: Center(
                  child: Text(
                    ' دخول كعميل',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
