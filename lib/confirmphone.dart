import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homecook/addmyservices.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:homecook/services/AuthService.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Confirmphone extends StatefulWidget {
  var _phonecontroler;
  Confirmphone(this._phonecontroler);
  @override
  _ConfirmphoneState createState() => _ConfirmphoneState(_phonecontroler);
}

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class _ConfirmphoneState extends State<Confirmphone> {
  var _phonecontroler;
  _ConfirmphoneState(this._phonecontroler);
  final formKey = new GlobalKey<FormState>();

  String verificationId, smsCode;
  String phoneNo;

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    print(number);
    setState(() {
      phoneNo = internationalizedPhoneNumber;
      print(internationalizedPhoneNumber);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneNo = _phonecontroler;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "الرجاء الانتظار لتأكيد رقم الجوال ",
              style: TextStyle(color: Color(0xFF153e90), fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: formKey,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(color: Colors.grey[50]),
                child: InternationalPhoneInput(
                  decoration:
                      InputDecoration.collapsed(hintText: 'ادخل رقم الجوال '),
                  onPhoneNumberChange: onPhoneNumberChange,
                  initialPhoneNumber: phoneNo,
                  initialSelection: '+966',
                  enabledCountries: ['+966'],
                  showCountryCodes: true,
                  showCountryFlags: true,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                createUserWithPhone(phoneNo, context);
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Color(0xFF153e90),
                  border: Border.all(color: Colors.blue),
                ),
                child: Center(
                  child: Text("تم",
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
    );
  }

  Future createUserWithPhone(String phone, BuildContext context) async {
    _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 5),
        verificationCompleted: (AuthCredential authCredential) {
          _firebaseAuth
              .signInWithCredential(authCredential)
              .then((AuthResult result) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => Addmyservices()));
          }).catchError((e) {
            return "error";
          });
        },
        verificationFailed: (AuthException exception) {
          Fluttertoast.showToast(
              msg: "الرجاء التأكد من صحة رقم الجوال",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          print(exception);
          return "error";
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          final _codeController = TextEditingController();
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: Text("ادخل الكود"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[TextField(controller: _codeController)],
              ),
              actions: <Widget>[
                Center(
                  child: FlatButton(
                    child: Text("موافق"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                      if (_codeController != null) {
                        var _credential = PhoneAuthProvider.getCredential(
                            verificationId: verificationId,
                            smsCode: _codeController.text.trim());

                        _firebaseAuth
                            .signInWithCredential(_credential)
                            .then((AuthResult result) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Addmyservices()));
                        }).catchError((e) {
                          return "error";
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg: "الرجاء ادخال الكود",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        ;
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
        });
  }
}
