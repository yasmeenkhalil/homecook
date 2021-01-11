import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import './services/CookerService.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RateCooker extends StatefulWidget {
  var id;
  RateCooker(this.id);
  @override
  _RateCookerState createState() => _RateCookerState(id);
}

var rate;
TextEditingController _comment = TextEditingController();

class _RateCookerState extends State<RateCooker> {
  var id;
  _RateCookerState(this.id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Color(0xFF153e90),
        body: SingleChildScrollView(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(color: Colors.grey),
                child: Stack(alignment: Alignment.center, children: [
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.14),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "تقييم الطباخ",
                            style: TextStyle(
                              color: Color(0xFF153e90),
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w700,
                              fontSize: 23,
                              height: 2,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              rate = rating;
                              print(rating);
                            },
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Text("اضغط على النجم للتقييم",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w400,
                                fontSize: 23,
                              )),
                          SizedBox(
                            height: 18.0,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "اترك تعليق او شكوى",
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 75, 74, 75),
                                          fontFamily: "Rubik",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          height: 2,
                                        ),
                                      ),
                                    ),
                                    TextField(
                                      controller: _comment,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: 18.0,
                                            bottom: 18.0,
                                            left: 6.0,
                                            right: 2.0),
                                        border: InputBorder.none,
                                        fillColor:
                                            Color.fromARGB(255, 232, 230, 230),
                                        filled: true,
                                      ),
                                      maxLines: 7,
                                    ),
                                    SizedBox(
                                      height: 12.0,
                                    ),
                                  ],
                                ),
                              )),
                          Spacer(),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: FlatButton(
                              onPressed: () {
                                if (rate != null) {
                                  Map<String, dynamic> data = {
                                    "id": id,
                                    "rate": rate,
                                    "comment": _comment.text,
                                  };
                                  var response =
                                      CookerService().ratecooker(data);
                                  if (response.statusCode == 200) {
                                    Fluttertoast.showToast(
                                        msg: " تم ارسال التقييم",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 2,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                }
                              },
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              textColor: Color.fromARGB(255, 255, 255, 255),
                              padding: EdgeInsets.all(0),
                              child: Text(
                                "تقييم",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30.0),
                        ],
                      )),
                ]))));
  }
}
