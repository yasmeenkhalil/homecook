import 'package:flutter/material.dart';
import 'package:homecook/menucooker.dart';
import 'package:homecook/myseconddishes.dart';
import 'package:homecook/appBarMain.dart';
import './services/KindService.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:homecook/constants.dart';
import './services/MaindishService.dart';
import './myservices.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import './services/networkhandler.dart';

class Addmyservices extends StatefulWidget {
  @override
  _AddmyservicesState createState() => _AddmyservicesState();
}

FlutterSecureStorage storge = FlutterSecureStorage();

final ImagePicker _picker = ImagePicker();
PickedFile _imageFile;
TextEditingController _detailescontroler = TextEditingController();
networkhandler Networkhandler = networkhandler();

GlobalKey<FormState> _globalkey4 = GlobalKey<FormState>();
GlobalKey<FormState> _globalkey2 = GlobalKey<FormState>();

class _AddmyservicesState extends State<Addmyservices> {
  String Specialization;
  List UserType = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getkinds();
  }

  var id;
  getkinds() async {
    var kinds = await KindService().getKind();
    this.UserType = kinds;
    setState(() {
      print(kinds);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('l'),
        automaticallyImplyLeading: true,
        backgroundColor: kPrimaryColor,
      ),
      endDrawer: Menucooker(),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Form(
            key: _globalkey4,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "اضافة خدماتي ",
                    style: TextStyle(color: kPrimaryColor, fontSize: 25),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 120),
                  child: Text("طريقة طبخ الذبيحة ",
                      style: TextStyle(fontSize: 18, color: kPrimaryColor)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.66,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20)),
                      // padding: const EdgeInsets.only(right: 20.0, left: 20),

                      child: Center(
                        child: DropdownButton(
                          hint: Text(
                            "       اختر طريقة الطبخ               ",
                            style: TextStyle(
                                fontSize: 15, color: Color(0xFF01a9b4)),
                          ),
                          value: Specialization,
                          onChanged: (value) {
                            setState(() {
                              Specialization = value;
                            });
                          },
                          items: UserType.map((user) {
                            return DropdownMenuItem(
                                value: user['_id'],
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    user['name'],
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ));
                          }).toList(),
                        ),
                      ),
                    ),
                    Container(
                        child: IconButton(
                      icon: Icon(Icons.add, color: Color(0xFF01a9b4)),
                      onPressed: () {
                        add(context);
                      },
                    ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 142),
                  child: Text("تفاصيل الطبخة ",
                      style: TextStyle(fontSize: 18, color: kPrimaryColor)),
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.8,
                    color: Colors.grey[100],
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: _detailescontroler,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'الرجاء ادخال  التفاصيل ';
                          }

                          return null;
                        },
                        maxLines: 7,
                        decoration: InputDecoration.collapsed(
                            hintText:
                                "          ادخل التفاصيل هنا                ",
                            hintStyle: TextStyle(
                                color: Color(0xFF01a9b4), fontSize: 15)),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 142),
                  child: Text(" صورة لطبخة سابقة ",
                      style: TextStyle(fontSize: 18, color: kPrimaryColor)),
                ),
                SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 190.0,
                      height: 150.0,
                      // margin: EdgeInsets.only(left: 35),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey[100]),
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
                            shape: BoxShape.circle, color: Color(0xFF01a9b4)),
                        child: Center(
                          child: InkWell(
                              onTap: () {},
                              child: IconButton(
                                icon: Icon(Icons.edit, color: Colors.white),
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: ((BuildContext context) =>
                                          setimage(context)));
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
                    if (_globalkey4.currentState.validate()) {
                      if (_imageFile != null) {
                        Map<String, dynamic> data = {
                          "detailes": _detailescontroler.text,
                          "kindId": Specialization
                        };
                        var response =
                            await MaindishesService().addmaindish(data);
                        if (response.statusCode == 200) {
                          Map<String, dynamic> output =
                              json.decode(response.body);
                          print(output['id']);
                          if (_imageFile != null) {
                            var imageResponse = await Networkhandler.patchimage(
                                "maindish/image/${output['id']}",
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Myservices()));
                            }
                          }
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: "الرجاء اختيار صورة  ",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    }
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Color(0xFF153e90),
                      border: Border.all(color: Colors.blue),
                    ),
                    child: Center(
                      child: Text('اضافة الطبخة',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  add(context) {
    final _codeController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            "ادخل الطريقة",
            style: TextStyle(fontSize: 18, color: kPrimaryColor),
          ),
        ),
        content: Form(
          key: _globalkey2,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: _codeController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'الرجاء ادخال اسم الطبخة ';
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                FlatButton(
                    child: Text("موافق"),
                    textColor: Colors.white,
                    color: kPrimaryColor,
                    onPressed: () async {
                      if (_globalkey2.currentState.validate()) {
                        Map<String, dynamic> data = {
                          "name": _codeController.text,
                        };
                        var response = await KindService().addKind(data);
                        if (response.statusCode == 200) {
                          Fluttertoast.showToast(
                              msg:
                                  "تم اضاقتها بنجاح بامكانك اختيارها من طريثة طبخ الذبيحة",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          getkinds();
                          Navigator.of(context).pop();
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget setimage(BuildContext context) {
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
