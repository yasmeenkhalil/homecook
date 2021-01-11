import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homecook/cookerchooseimage.dart';
import 'package:homecook/services/networkhandler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Cookerregister extends StatefulWidget {
  @override
  _CookerregisterState createState() => _CookerregisterState();
}

FirebaseMessaging _messagetoken = new FirebaseMessaging();

GlobalKey<FormState> _globalkey1 = GlobalKey<FormState>();
TextEditingController _namecontroler = TextEditingController();
TextEditingController _phonecontroler = TextEditingController();
TextEditingController _bankcontroler = TextEditingController();

TextEditingController _passwordcontroler = TextEditingController();
bool pass = true;
networkhandler Networkhandler = networkhandler();
final storage = new FlutterSecureStorage();
final List<String> errors = [];
String token;

class _CookerregisterState extends State<Cookerregister> {
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

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
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
          child: Center(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
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
                  Form(
                    key: _globalkey1,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(color: Colors.grey[50]),
                            child: TextFormField(
                                controller: _namecontroler,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'الرجاء ادخال الاسم الثنائي';
                                  }
                                  return null;
                                },
                                obscureText: false,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.black),
                                  hintText: "الاسم ثنائي",
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
                                controller: _bankcontroler,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'الرجاء ادخال رقم ايبان البنك';
                                  }
                                  return null;
                                },
                                obscureText: false,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.black),
                                  hintText: "ايبان البنك",
                                  hintStyle: TextStyle(
                                      color: Color(0xFF153e90), fontSize: 20),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  prefixIcon: Icon(
                                    Icons.account_balance,
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
                              if (_globalkey1.currentState.validate()) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Chooseimage(
                                            _namecontroler,
                                            _passwordcontroler,
                                            _phonecontroler,
                                            _bankcontroler,
                                            token)));
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
