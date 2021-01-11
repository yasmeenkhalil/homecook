import 'package:flutter/material.dart';
import './services/UserService.dart';
import './menuuser.dart';

class UserSubscriptions extends StatefulWidget {
  @override
  _UserSubscriptionsState createState() => _UserSubscriptionsState();
}

class _UserSubscriptionsState extends State<UserSubscriptions> {
  @override
  void initState() {
    getsubscription();
    super.initState();
  }

  List subscriptions = [];
  getsubscription() async {
    var response = await UserService().getsubscriptions();
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
      endDrawer: Menuuser(),
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
                          "طلبات الطبخات الخاصة بك",
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
                      height: MediaQuery.of(context).size.height * 0.75,
                      color: Color(0xFF153e90),
                      child: ListView.builder(
                          itemCount: subscriptions.length > 0
                              ? subscriptions.length
                              : 0,
                          padding: EdgeInsets.only(top: 0.0),
                          itemBuilder: (BuildContext context, int index) {
                            return SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  //Yaha sa start ha ya pora info
                                  GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          //height: MediaQuery.of(context).size.height*0.3,
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.019,
                                              bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.07),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Text(
                                                  subscriptions[index]
                                                              ['kind'] !=
                                                          null
                                                      ? subscriptions[index]
                                                              ['kind']
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
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        subscriptions[index][
                                                                    'slicenumbers'] !=
                                                                null
                                                            ? (250 *
                                                                    int.parse(subscriptions[index]
                                                                            [
                                                                            'slicenumbers']
                                                                        .toString()))
                                                                .toString()
                                                            : "",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      Text(
                                                        "سعر الطبق الرئيسي",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      Text(
                                                        subscriptions[index][
                                                                    'slicenumbers'] !=
                                                                null
                                                            ? subscriptions[
                                                                        index][
                                                                    'slicenumbers']
                                                                .toString()
                                                            : "",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      Text(
                                                        "عدد الذبائح",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ]),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        subscriptions[index][
                                                                    'insurance'] !=
                                                                null
                                                            ? subscriptions[
                                                                        index][
                                                                    'insurance']
                                                                .toString()
                                                            : "",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      Text(
                                                        " تأمين الصحون",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      Text(
                                                        subscriptions[index][
                                                                    'dishescount'] !=
                                                                null
                                                            ? subscriptions[
                                                                        index][
                                                                    'dishescount']
                                                                .toString()
                                                            : "",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      Text(
                                                        "عدد الصحون",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ]),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        subscriptions[index]
                                                                    ['price'] !=
                                                                null
                                                            ? (int.parse(subscriptions[index]
                                                                            [
                                                                            'price']
                                                                        .toString()) /
                                                                    100)
                                                                .toString()
                                                            : "",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      Text(
                                                        "السعر الكلي مع الأطباق الجانبية",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ])
                                              ]))),
                                  SizedBox(height: 10.0)
                                ],
                              ),
                            );
                          }))
                  : Center(child: CircularProgressIndicator()),
            ])
          ]),
        ),
      ),
    );
  }
}
