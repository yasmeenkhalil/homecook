import 'package:flutter/material.dart';
import 'package:homecook/menucooker.dart';
import 'package:homecook/myseconddishes.dart';
import 'package:homecook/myservices.dart';
import 'package:homecook/appBarMain.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import './services/networkhandler.dart';
import './services/Seconddish.dart';
import './myseconddishes.dart';

class Anotherservices extends StatefulWidget {
  @override
  _AnotherservicesState createState() => _AnotherservicesState();
}

FlutterSecureStorage storge = FlutterSecureStorage();

final ImagePicker _picker = ImagePicker();
PickedFile _imageFile;
TextEditingController _namecontroler = TextEditingController();
TextEditingController _sizecontroler = TextEditingController();
TextEditingController _pricecontroler = TextEditingController();
networkhandler Networkhandler = networkhandler();

GlobalKey<FormState> _globalkey3 = GlobalKey<FormState>();

class _AnotherservicesState extends State<Anotherservices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text('l'),
          automaticallyImplyLeading: true,
          backgroundColor: Color(0xFF153e90),
        ),
        endDrawer: Menucooker(),
        body: SingleChildScrollView(
            child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Directionality(
              textDirection: TextDirection.rtl,
              child: Center(
                child: Form(
                  key: _globalkey3,
                  child: Column(children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "اضافة طبق جانبي ",
                        style:
                            TextStyle(color: Color(0xFF153e90), fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.95,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(children: [
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 200),
                          child: Text("اسم الصنف",
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xFF153e90))),
                        ),
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(color: Colors.grey[50]),
                          child: TextFormField(
                              controller: _namecontroler,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'الرجاء ادخال  الاسم ';
                                }

                                return null;
                              },
                              obscureText: false,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.black),
                                contentPadding:
                                    EdgeInsets.only(right: 20, bottom: 10),
                                hintText: "مثال : ايدام البطاطس",
                                hintStyle: TextStyle(
                                    color: Color(0xFF01a9b4), fontSize: 15),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 200),
                          child: Text("السعر",
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xFF153e90))),
                        ),
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(color: Colors.grey[50]),
                          child: TextFormField(
                              controller: _pricecontroler,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'الرجاء ادخال  السعر ';
                                }

                                return null;
                              },
                              obscureText: false,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.black),
                                contentPadding:
                                    EdgeInsets.only(right: 20, bottom: 10),
                                hintText: "20",
                                hintStyle: TextStyle(
                                    color: Color(0xFF01a9b4), fontSize: 15),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 200),
                          child: Text("الحجم",
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xFF153e90))),
                        ),
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(color: Colors.grey[50]),
                          child: TextFormField(
                              controller: _sizecontroler,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'الرجاء ادخال  الحجم ';
                                }

                                return null;
                              },
                              obscureText: false,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.black),
                                contentPadding:
                                    EdgeInsets.only(right: 20, bottom: 10),
                                hintText: "كبير أو وسط أو صغير",
                                hintStyle: TextStyle(
                                    color: Color(0xFF01a9b4), fontSize: 15),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 200),
                          child: Text(" صورة الصنف ",
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xFF153e90))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Stack(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 150.0,
                              height: 150.0,
                              // margin: EdgeInsets.only(left: 35),
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[100]),
                                child: ClipOval(
                                  child: Image(
                                    image: _imageFile != null
                                        ? FileImage(File(_imageFile.path))
                                        : AssetImage('assets/images/food.png'),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 110.0,
                              right: 110,
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                height: 36.0,
                                width: 36.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF01a9b4)),
                                child: Center(
                                  child: InkWell(
                                      onTap: () {},
                                      child: IconButton(
                                        icon: Icon(Icons.edit,
                                            color: Colors.white),
                                        onPressed: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: ((builder) =>
                                                  setimage()));
                                        },
                                      )),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        InkWell(
                          onTap: () async {
                            if (_globalkey3.currentState.validate()) {
                              if (_imageFile != null) {
                                Map<String, dynamic> data = {
                                  'name': _namecontroler.text,
                                  'price': _pricecontroler.text,
                                  'size': _sizecontroler.text
                                };
                                var response = await SeconddishService()
                                    .addseconddish(data);
                                if (response.statusCode == 200) {
                                  Map<String, dynamic> output =
                                      json.decode(response.body);
                                  print(output['id']);
                                  if (_imageFile != null) {
                                    var imageResponse =
                                        await Networkhandler.patchimage(
                                            "seconddish/image/${output['id']}",
                                            _imageFile.path);
                                    if (imageResponse.statusCode == 200) {
                                      Fluttertoast.showToast(
                                          msg: "تم اضافته بنجاح",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.TOP,
                                          timeInSecForIosWeb: 2,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (_) =>
                                      //             Myseconddishes()));
                                    }
                                  }
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "الرجاء اختيار صورة  ",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.TOP,
                                    timeInSecForIosWeb: 4,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            }
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: BoxDecoration(
                              color: Color(0xFF153e90),
                              border: Border.all(color: Colors.blue),
                            ),
                            child: Center(
                              child: Text('اضافة',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ]),
                ),
              )),
        )));
  }

  Widget setimage() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            'choose profile photo',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                tackphoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                tackphoto(ImageSource.gallery);
              },
              label: Text("Gallary"),
            ),
          ]),
        ],
      ),
    );
  }

  void tackphoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _imageFile = pickedFile;
      } else {
        print('No image selected.');
      }
    });
  }
}
