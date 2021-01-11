import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homecook/confirmphone.dart';
import 'package:provider/provider.dart';
import 'package:homecook/services/cookerService.dart';
import 'package:homecook/services/networkhandler.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Chooselocation extends StatefulWidget {
  var _namecontroler,
      _passwordcontroler,
      _phonecontroler,
      _bankcontroler,
      _imageFile,
      token;

  Chooselocation(this._namecontroler, this._passwordcontroler,
      this._phonecontroler, this._bankcontroler, this._imageFile, this.token);
  @override
  _ChooselocationState createState() => _ChooselocationState(_namecontroler,
      _passwordcontroler, _phonecontroler, _bankcontroler, _imageFile, token);
}

networkhandler Networkhandler = networkhandler();

List<Marker> mymarker = [];
var lat;
var lng;
final storage = new FlutterSecureStorage();

class _ChooselocationState extends State<Chooselocation> {
  var _namecontroler,
      _passwordcontroler,
      _phonecontroler,
      _bankcontroler,
      _imageFile,
      token;
  _ChooselocationState(this._namecontroler, this._passwordcontroler,
      this._phonecontroler, this._bankcontroler, this._imageFile, this.token);
  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(top: 50),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Text(
                "الموقع على الخريطة",
                style: TextStyle(color: Color(0xFF153e90), fontSize: 20),
              ),
              Text(
                "اضغط على الخريطة واستعمل المؤشر لاختيار المكان  ",
                style: TextStyle(color: Color(0xFF153e90), fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: currentPosition != null
                    ? GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(currentPosition.latitude,
                              currentPosition.longitude),
                          zoom: 8.0,
                        ),
                        zoomControlsEnabled: true,
                        mapToolbarEnabled: true,
                        markers: Set.from(mymarker),
                        onTap: _handelTap,
                      )
                    : Center(child: CircularProgressIndicator()),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () async {
                  if (lng != null && lat != null) {
                    Map<String, dynamic> data = {
                      "name": _namecontroler.text,
                      "password": _passwordcontroler.text,
                      "phone": _phonecontroler.text,
                      "bank": _bankcontroler.text,
                      "lat": lat,
                      "lng": lng,
                      'token': token
                    };
                    var response = await CookerService().signin(data);
                    if (response.statusCode == 200) {
                      Map<String, dynamic> output = json.decode(response.body);
                      print(output['token']);
                      await storage.write(key: 'token', value: output['token']);
                      if (_imageFile != null) {
                        var imageResponse = await Networkhandler.patchimage(
                            "cookers/image", _imageFile);
                        if (imageResponse.statusCode == 200) {
                          Fluttertoast.showToast(
                              msg: "تم التسجيل بنجاح",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      Confirmphone(_phonecontroler.text)));
                        }
                      }
                    }
                  } else {
                    Fluttertoast.showToast(
                        msg: "الرجاء اختيار موقعك",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 2,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
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
                    child: Text('تسجيل الدخول',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  _handelTap(LatLng tappedPoinet) {
    lat = tappedPoinet.latitude;
    lng = tappedPoinet.longitude;
    print(lat);
    print(lng);
    setState(() {
      mymarker = [];
      mymarker.add(Marker(
          markerId: MarkerId(tappedPoinet.toString()),
          position: tappedPoinet,
          draggable: true,
          onDragEnd: (dragEndPostion) {
            print(dragEndPostion);
            lat = dragEndPostion.latitude;
            lng = dragEndPostion.longitude;
            print(lat);
            print(lng);
          }));
    });
  }
}
