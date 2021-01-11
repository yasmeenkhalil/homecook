/*
*  privacy_policy_widget.dart
*  OWNERP$U
*
*  Created by A.C. Wheeler.
*  Copyright © 2018 Parking 4 U. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:homecook/menucooker.dart';
import 'package:homecook/appBarMain.dart';
import 'package:homecook/services/networkhandler.dart';

class PrivacyPolicy extends StatefulWidget {
  //void onIAgreeButtonPressed(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterWidget()));

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  var response;
  var privecy;
  networkhandler Networkhandler = networkhandler();
  getprivecy() async {
    response = await Networkhandler.get('privacy');

    setState(() {
      privecy = response;
      print(privecy);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: new AppBar(
            title: Text(''),
            automaticallyImplyLeading: true,
            backgroundColor: Color(0xFF153e90)),
        endDrawer: Menucooker(),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Color(0xFF153e90)),
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.13,
                          left: MediaQuery.of(context).size.width * 0.05,
                          right: MediaQuery.of(context).size.width * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "الشروط والأحكام ",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w700,
                                fontSize: 40,
                                height: 1,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SingleChildScrollView(
                              child: Column(
                            children: <Widget>[
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(75),
                                      topRight: Radius.circular(75)),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          Text(privecy != null ? privecy : "",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: Color(0xFF153e90),
                                                fontFamily: "SF Pro Text",
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                letterSpacing: 0.175,
                                                height: 1.57143,
                                              )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                        ],
                      ))
                ],
              ),
            ],
          )),
        ));
  }
}
