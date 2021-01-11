import 'package:flutter/material.dart';
import 'package:homecook/cofirmuserphone.dart';
import './services/networkhandler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import './services/UserService.dart';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';

class Userregister extends StatefulWidget {
  @override
  _UserregisterState createState() => _UserregisterState();
}

FirebaseMessaging _messagetoken = new FirebaseMessaging();
String token;

class _UserregisterState extends State<Userregister> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _messagetoken.getToken().then((t) => {
          setState(() {
            token = t;
          })
        });
  }

  GlobalKey<FormState> _globalkey6 = GlobalKey<FormState>();
  TextEditingController _namecontroler = TextEditingController();
  TextEditingController _phonecontroler = TextEditingController();

  TextEditingController _passwordcontroler = TextEditingController();
  bool pass = true;
  networkhandler Networkhandler = networkhandler();
  final storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            child: Form(
              key: _globalkey6,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Center(
                        child: Text("تسجيل الدخول",
                            style: TextStyle(
                                fontSize: 30, color: Color(0xFF153e90)))),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.80,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(color: Colors.grey[50]),
                          child: TextFormField(
                              controller: _namecontroler,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'الرجاء ادخال الاسم ';
                                }
                                return null;
                              },
                              obscureText: false,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.black),
                                hintText: "الاسم",
                                hintStyle: TextStyle(
                                    color: Color(0xFF153e90), fontSize: 20),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                prefixIcon: Icon(
                                  Icons.person,
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
                              controller: _phonecontroler,
                              validator: (value) {
                                if (value.isEmpty)
                                  return 'الرجاء ادخال رقم الجوال';
                                if (value.length < 9)
                                  return 'الرجاء ادخال رقم الجوال بطريقة صحيحة';
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
                              validator: (value) {
                                if (value.isEmpty)
                                  return 'الرجاء ادخال كلمة المرور';

                                if (value.length < 8)
                                  return 'يجب أن تكون كلمة المرور من 8 حروف أو أرقام';

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
                                prefixIcon: IconButton(
                                  icon: Icon(Icons.remove_red_eye),
                                  onPressed: () {
                                    setState(() {
                                      pass = !pass;
                                    });
                                  },
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
                            if (_globalkey6.currentState.validate()) {
                              Map<String, dynamic> data = {
                                "name": _namecontroler.text,
                                "password": _passwordcontroler.text,
                                "phone": _phonecontroler.text,
                                'token': token
                              };
                              var response = await UserService().signin(data);
                              if (response.statusCode == 200) {
                                Map<String, dynamic> output =
                                    json.decode(response.body);
                                print(output['token']);
                                await storage.write(
                                    key: 'token', value: output['token']);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => Confirmuserphone(
                                            _phonecontroler.text)));
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
                              child: Text('التالي',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
