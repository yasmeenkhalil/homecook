import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homecook/chooselocation.dart';
import 'package:homecook/services/networkhandler.dart';
import 'package:image_picker/image_picker.dart';

class Chooseimage extends StatefulWidget {
  var _namecontroler,
      _passwordcontroler,
      _phonecontroler,
      _bankcontroler,
      token;
  Chooseimage(this._namecontroler, this._passwordcontroler,
      this._phonecontroler, this._bankcontroler, this.token);
  @override
  _ChooseimageState createState() => _ChooseimageState(_namecontroler,
      _passwordcontroler, _phonecontroler, _bankcontroler, token);
}

final ImagePicker _picker = ImagePicker();
PickedFile _imageFile;
networkhandler Networkhandler = networkhandler();

class _ChooseimageState extends State<Chooseimage> {
  var _namecontroler,
      _passwordcontroler,
      _phonecontroler,
      _bankcontroler,
      token;
  _ChooseimageState(this._namecontroler, this._passwordcontroler,
      this._phonecontroler, this._bankcontroler, this.token);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Sheet(_namecontroler, _passwordcontroler, _phonecontroler,
            _bankcontroler, token));
  }
}

class Sheet extends StatefulWidget {
  final _namecontroler,
      _passwordcontroler,
      _phonecontroler,
      _bankcontroler,
      token;
  Sheet(this._namecontroler, this._passwordcontroler, this._phonecontroler,
      this._bankcontroler, this.token);

  @override
  _SheetState createState() => _SheetState();
}

class _SheetState extends State<Sheet> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(children: [
                  Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(children: [
                        SizedBox(
                          height: 60,
                        ),
                        Text(
                          "  صورة باب المنزل",
                          style:
                              TextStyle(fontSize: 30, color: Color(0xFF153e90)),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 250,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              image: DecorationImage(
                                  image: _imageFile != null
                                      ? FileImage(File(_imageFile.path))
                                      : AssetImage("assets/images/door.jpg"),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            tackphoto(ImageSource.camera);
                          },
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                            child: Center(
                              child: Text('التقاط صورة من الكاميرا',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            tackphoto(ImageSource.gallery);
                          },
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                            child: Center(
                              child: Text(' اختيار صورة من الاستديو',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () async {
                            if (_imageFile != null) {
                              // var imageResponse =
                              //     await Networkhandler.patchimage(
                              //         "cookers/image", _imageFile.path);
                              // if (imageResponse.statusCode == 200) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Chooselocation(
                                          widget._namecontroler,
                                          widget._passwordcontroler,
                                          widget._phonecontroler,
                                          widget._bankcontroler,
                                          _imageFile.path,
                                          widget.token)));
                            } else {
                              showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('AlertDialog Title'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text('This is a demo alert dialog.'),
                                          Text(
                                              'Would you like to approve of this message?'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Approve'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              color: Color(0xFF153e90),
                              border: Border.all(color: Colors.blue),
                            ),
                            child: Center(
                              child: Text("التالي",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ),
                      ]))
                ]))));
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
          Container(
            height: 30,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: FlatButton.icon(
                      icon: Icon(Icons.camera),
                      onPressed: () {
                        tackphoto(ImageSource.camera);
                      },
                      label: Text("Camera"),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: FlatButton.icon(
                      icon: Icon(Icons.image),
                      onPressed: () {
                        tackphoto(ImageSource.gallery);
                      },
                      label: Text("Gallary"),
                    ),
                  ),
                ]),
          ),
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
