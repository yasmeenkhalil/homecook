import 'package:flutter/material.dart';
import 'package:homecook/rentcooker.dart';
import 'package:homecook/userregister.dart';
import 'package:homecook/services/UserService.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Loginasuser extends StatefulWidget {
  @override
  _LoginasuserState createState() => _LoginasuserState();
}

FirebaseMessaging _messagetoken = new FirebaseMessaging();

TextEditingController _passwordcontroler = TextEditingController();
TextEditingController _phonecontroler = TextEditingController();
FlutterSecureStorage storge = FlutterSecureStorage();
GlobalKey<FormState> _globalkey10 = GlobalKey<FormState>();

class _LoginasuserState extends State<Loginasuser> {
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
      appBar: AppBar(
        backgroundColor: Color(0xFF153e90),
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
          child: Container(),
        ),
      ),
      body: Form(
        key: _globalkey10,
        child: SingleChildScrollView(
          child: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Column(children: [
                  Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                          child: Column(children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                        ),
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
                              obscureText: true,
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
                                suffixIcon: Icon(Icons.remove_red_eye),
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
                            if (_globalkey10.currentState.validate()) {
                              Map<String, dynamic> data = {
                                "password": _passwordcontroler.text,
                                "phone": _phonecontroler.text,
                              };
                              var response = await UserService().login(data);
                              if (response.statusCode == 200) {
                                Map<String, dynamic> output =
                                    json.decode(response.body);
                                print(output['token']);
                                await storge.write(
                                    key: 'token', value: output['token']);

                                Map<String, dynamic> data2 = {
                                  "token": token,
                                };
                                var response2 =
                                    await UserService().refreshtoken(data2);
                                setState(() {
                                  _passwordcontroler.text = "";
                                  _phonecontroler.text = "";
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => Rentcooker()));
                              } else {
                                if (response.statusCode == 401) {
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
                                          builder: (_) => Userregister()));
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
              )),
        ),
      ),
    );
  }
}
