import 'package:flutter/material.dart';
import './services/CookerService.dart';
import './splash/components/default_button.dart';
import './ratecooker.dart';

class Detailscooker extends StatefulWidget {
  var id;
  Detailscooker(this.id);
  @override
  _DetailscookerState createState() => _DetailscookerState(id);
}

class _DetailscookerState extends State<Detailscooker> {
  var id;
  _DetailscookerState(this.id);
  @override
  void initState() {
    getsubscription();
    super.initState();
  }

  var subscriptions;
  getsubscription() async {
    var response = await CookerService().getsubscriptionsone(id);
    if (mounted) {
      setState(() {
        subscriptions = response;
      });
    }
    print(subscriptions);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xFF153e90),
        title: Text(''),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0xFF153e90),
          ),
          child: Stack(alignment: Alignment.center, children: [
            Column(children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.15,
                //color:Colors.red
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.15,
                            right: MediaQuery.of(context).size.width * 0.15,
                            top: 4.0,
                            bottom: 4),
                        child: Text(
                          "المعلومات والتقييم",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        )),
                  ],
                ),
              ),
              subscriptions != null
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.55,
                      color: Color(0xFF153e90),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            //Yaha sa start ha ya pora info
                            GestureDetector(
                                onTap: () {},
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    //height: MediaQuery.of(context).size.height*0.3,
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.019,
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                0.07),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            subscriptions['kind'] != null
                                                ? subscriptions['kind']
                                                    .toString()
                                                : "",
                                            style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontFamily: "Roboto",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.019,
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  subscriptions[
                                                              'slicenumbers'] !=
                                                          null
                                                      ? (250 *
                                                              int.parse(subscriptions[
                                                                      'slicenumbers']
                                                                  .toString()))
                                                          .toString()
                                                      : "",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Roboto",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Text(
                                                  "سعر الطبق الرئيسي",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Roboto",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Text(
                                                  subscriptions[
                                                              'slicenumbers'] !=
                                                          null
                                                      ? subscriptions[
                                                              'slicenumbers']
                                                          .toString()
                                                      : "",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Roboto",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Text(
                                                  "عدد الذبائح",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Roboto",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ]),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  subscriptions['insurance'] !=
                                                          null
                                                      ? subscriptions[
                                                              'insurance']
                                                          .toString()
                                                      : "",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Roboto",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Text(
                                                  " تأمين الصحون",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Roboto",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Text(
                                                  subscriptions[
                                                              'dishescount'] !=
                                                          null
                                                      ? subscriptions[
                                                              'dishescount']
                                                          .toString()
                                                      : "",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Roboto",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Text(
                                                  "عدد الصحون",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Roboto",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ]),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  subscriptions['price'] != null
                                                      ? (int.parse(subscriptions[
                                                                      'price']
                                                                  .toString()) /
                                                              100)
                                                          .toString()
                                                      : "",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Roboto",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Text(
                                                  "السعر الكلي مع الأطباق الجانبية",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Roboto",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ])
                                        ]))),
                            SizedBox(height: 10.0)
                          ],
                        ),
                      ))
                  : Center(child: CircularProgressIndicator()),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => RateCooker(id)));
                  },
                  child: Text(
                    "التقييم والشكوى",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color(0xFF153e90),
                    ),
                  ),
                ),
              )
            ])
          ]),
        ),
      ),
    );
  }
}
