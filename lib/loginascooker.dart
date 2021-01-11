import 'package:flutter/material.dart';
import 'package:homecook/cookerregister.dart';
import 'package:homecook/myservices.dart';
import 'package:homecook/userregister.dart';
import 'package:homecook/services/cookerService.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Loginascooker extends StatefulWidget {
  @override
  _LoginascookerState createState() => _LoginascookerState();
}

bool pass = true;
TextEditingController _passwordcontroler = TextEditingController();
TextEditingController _phonecontroler = TextEditingController();
FlutterSecureStorage storge = FlutterSecureStorage();
GlobalKey<FormState> _globalkey5 = GlobalKey<FormState>();
FirebaseMessaging _messagetoken = new FirebaseMessaging();

class _LoginascookerState extends State<Loginascooker> {
  var token;
  @override
  void initState() {
    _messagetoken.getToken().then((t) => {
          setState(() {
            token = t;
            print('token' + token);
          })
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            // Here we create one to set status bar color
            backgroundColor: Color(0xFF153e90),
          ) // Set any color of status bar you want; or it defaults to your theme's primary color
          ),
      body: SingleChildScrollView(
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Form(
              key: _globalkey5,
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Column(children: [
                  Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                          child: Column(children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.15),
                        Center(
                          child: Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/images/user.png"),
                                    fit: BoxFit.fill)),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(color: Colors.grey[50]),
                          child: TextFormField(
                              controller: _phonecontroler,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'الرجاء ادخال رقم الجوال';
                                }

                                return null;
                              },
                              obscureText: false,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.black),
                                hintText: "رقم الجوال",
                                hintStyle: TextStyle(
                                    color: Color(0xFF153e90), fontSize: 20),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Color(0xFF153e90),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(color: Colors.grey[50]),
                          child: TextFormField(
                              controller: _passwordcontroler,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'الرجاء ادخال كلمة المرور';
                                }

                                return null;
                              },
                              obscureText: pass,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.black),
                                hintText: "كلمة المرور",
                                hintStyle: TextStyle(
                                    color: Color(0xFF153e90), fontSize: 20),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Color(0xFF153e90),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.remove_red_eye),
                                  onPressed: () {
                                    setState(() {
                                      pass = !pass;
                                    });
                                  },
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () async {
                            if (_globalkey5.currentState.validate()) {
                              Map<String, dynamic> data = {
                                "password": _passwordcontroler.text,
                                "phone": _phonecontroler.text,
                              };
                              var response = await CookerService().login(data);
                              if (response.statusCode == 200) {
                                Map<String, dynamic> output =
                                    json.decode(response.body);
                                print(output['token']);
                                await storage.write(
                                    key: 'token', value: output['token']);
                                Map<String, dynamic> data2 = {
                                  "token": token,
                                };
                                var response2 =
                                    await CookerService().refreshtoken(data2);

                                setState(() {
                                  _passwordcontroler.text = "";
                                  _phonecontroler.text = "";
                                });

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => Myservices()));
                              } else {
                                if (response.statusCode == 400) {
                                  Fluttertoast.showToast(
                                      msg: " رقم الجوال أو كلمة مرور غير صحيحة",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.TOP,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "لا يوجد اتصال بالانترنت",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.TOP,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              }
                            }
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              color: Color(0xFF153e90),
                              border: Border.all(color: Colors.blue),
                            ),
                            child: Center(
                              child: Text('دخول',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text('  ليس لديك حساب؟',
                                  textAlign: TextAlign.left),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Cookerregister()));
                                },
                                child: Text(
                                  'تسجيل الدخول  ',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ])))
                ]),
              ),
            )),
      ),
    );
  }
}
