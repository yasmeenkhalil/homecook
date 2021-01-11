import 'package:flutter/material.dart';
import 'package:homecook/details/details_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../services/CookerService.dart';
import '../../services/MaindishService.dart';
import '../../services/Seconddish.dart';
import 'package:homecook/detailssecond/detailssecond_screen.dart';
import 'package:homecook/constants.dart';
import '../../conversation.dart';
import '../../services/Database.dart';
import '../../services/UserService.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:homecook/size_config.dart';

class Body extends StatefulWidget {
  var id;
  var Specialization, cont, controller2, t, dateTime, newt;
  Body(this.id, this.Specialization, this.cont, this.controller2, this.t,
      this.dateTime, this.newt);
  @override
  _BodyState createState() =>
      _BodyState(id, Specialization, cont, controller2, t, dateTime, newt);
}

class _BodyState extends State<Body> {
  var id;
  var Specialization, cont, controller2, t, dateTime, newt;
  _BodyState(this.id, this.Specialization, this.cont, this.controller2, this.t,
      this.dateTime, this.newt);
  List categories = ['الأطباق الجانبية ', 'الأطباق الرئيسية'];
  String mytoken;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcooker();
    getme();
    getMaindishes();
    _messagetoken.getToken().then((t) => {
          setState(() {
            mytoken = t;
            print('mytoken' + mytoken);
          })
        });
  }

  var cooker;
  String token;
  String cookerid;
  String cookername;
  getcooker() async {
    var response = await CookerService().getcookerwithid(id);
    setState(() {
      cooker = response;
      cookername = cooker['name'];
      token = cooker['token'];
      cookerid = cooker['_id'];
      print(cookerid);
    });
  }

  List maindishes = [];
  getMaindishes() async {
    if (selectedIndex == 1) {
      var response2 = await MaindishesService().getdishesforcooker(id);
      setState(() {
        maindishes = response2;
      });
    } else if (selectedIndex == 0) {
      var response3 = await SeconddishService().getdishesforcooker(id);
      setState(() {
        maindishes = response3;
      });
    }
  }

  var user;
  String myname;
  String myid;
  getme() async {
    var response2 = await UserService().getuser();
    setState(() {
      user = response2;
      myname = user['name'];
      myid = user['_id'];
      print(myname);
    });
  }

  DatabaseMethods databaseMethods = new DatabaseMethods();
  FirebaseMessaging _messagetoken = new FirebaseMessaging();
  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  createChatroomandstart() {
    List<String> users = [token, mytoken];
    List<String> names = [cookername, myname];
    List<String> ids = [cookerid, myid];

    String chatRoomId = getChatRoomId(cookerid, myid);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "names": names,
      "ids": ids,
      "chatRoomId": chatRoomId,
    };

    databaseMethods.addChatRoom(chatRoom, chatRoomId);
    print(controller2);
    print(t.toString());
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Conversation(chatRoomId, cookerid,
                Specialization, cont, controller2, t, dateTime, newt)));
  }

  askingfocooker() async {
    Map<String, dynamic> data = {
      "asking": false,
      "CookerId": cookerid,
    };
    var response = await UserService().askingforcooker(data);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      bottom: false,
      child: cooker != null
          ? Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Text('معلومات الطباخ',
                        style: TextStyle(fontSize: 30, color: Colors.white))),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(cooker['name'] != null ? cooker['name'] : "",
                          style: TextStyle(fontSize: 30, color: Colors.white)),
                      RatingBarIndicator(
                        rating: cooker['Rating'].toDouble(),
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 28.0,
                        direction: Axis.horizontal,
                      ),
                    ],
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     createChatroomandstart();
                  //   },
                  //   child: Container(
                  //     height: 40,
                  //     width: MediaQuery.of(context).size.width * 0.3,
                  //     decoration: BoxDecoration(
                  //         color: Color(0xFF153e90),
                  //         borderRadius: BorderRadius.all(
                  //           Radius.circular(20),
                  //         )),
                  //     child: Center(
                  //       child: Text(' التواصل ',
                  //           style: TextStyle(
                  //               fontSize: 20,
                  //               color: Colors.white,
                  //               fontWeight: FontWeight.w500)),
                  //     ),
                  //   ),
                  // ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
                  height: 30,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          getMaindishes();
                        });
                      },
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                            left: 50,
                            // At end item it add extra 20 right  padding
                            right: index == categories.length - 1 ? 30 : 0,
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: kDefaultPadding),
                          decoration: BoxDecoration(
                            color: index == selectedIndex
                                ? Colors.white.withOpacity(0.4)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            categories[index],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: kDefaultPadding / 2),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      // Our background
                      Container(
                        margin: EdgeInsets.only(top: 70),
                        decoration: BoxDecoration(
                          color: kBackgroundColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                      ),
                      selectedIndex == 1
                          ? ListView.builder(

                              // here we use our demo procuts list
                              itemCount:
                                  maindishes.length > 0 ? maindishes.length : 0,
                              padding: EdgeInsets.only(top: 0.0),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding,
                                    vertical: kDefaultPadding / 2,
                                  ),
                                  height: 160,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailsScreen(
                                                      maindishes[index]
                                                          ['_id'])));
                                    },
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: <Widget>[
                                        // Those are our background
                                        Container(
                                          height: 136,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(22),
                                            color: index.isEven
                                                ? kBlueColor
                                                : kSecondaryColor,
                                            boxShadow: [kDefaultShadow],
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(22),
                                            ),
                                          ),
                                        ),
                                        // our product image
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Hero(
                                            tag: 'yas',
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: kDefaultPadding),
                                              height: 150,
                                              // image is square but we add extra 20 + 20 padding thats why width is 200
                                              width: 150,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: maindishes[index]
                                                              ['image'] !=
                                                          null
                                                      ? NetworkImage(
                                                          'https://homekitchen1.herokuapp.com/upload/${maindishes[index]['image']}')
                                                      : AssetImage(
                                                          "assets/images/food.png"),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Product title and price
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          child: SizedBox(
                                            height: 136,
                                            // our image take 200 width, thats why we set out total width - 200
                                            width: size.width - 200,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Spacer(),

                                                Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Center(
                                                          child: Text(
                                                              maindishes[index][
                                                                          'kindId'] !=
                                                                      null
                                                                  ? maindishes[
                                                                              index]
                                                                          [
                                                                          'kindId']
                                                                      ['name']
                                                                  : '',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      18.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Color(
                                                                      0xFF153e90))),
                                                        ),
                                                        Text(
                                                            maindishes[index][
                                                                        'detailes'] !=
                                                                    null
                                                                ? maindishes[
                                                                        index]
                                                                    ['detailes']
                                                                : "",
                                                            style: TextStyle(
                                                                fontSize: 13.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color(
                                                                    0xFF153e90))),
                                                      ]),
                                                ),

                                                // it use the available space
                                                Spacer(),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        kDefaultPadding *
                                                            0.7, // 30 padding
                                                    vertical: kDefaultPadding /
                                                        5, // 5 top and bottom
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: kSecondaryColor,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(22),
                                                      topRight:
                                                          Radius.circular(22),
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
                                );
                              })
                          : ListView.builder(

                              // here we use our demo procuts list
                              itemCount:
                                  maindishes.length > 0 ? maindishes.length : 0,
                              padding: EdgeInsets.only(top: 0.0),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding,
                                    vertical: kDefaultPadding / 2,
                                  ),
                                  height: 160,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailssecondScreen(
                                                      maindishes[index]
                                                          ['_id'])));
                                    },
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: <Widget>[
                                        // Those are our background
                                        Container(
                                          height: 136,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(22),
                                            color: index.isEven
                                                ? kBlueColor
                                                : kSecondaryColor,
                                            boxShadow: [kDefaultShadow],
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(22),
                                            ),
                                          ),
                                        ),
                                        // our product image
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Hero(
                                            tag: 'second',
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: kDefaultPadding),
                                              height: 150,
                                              // image is square but we add extra 20 + 20 padding thats why width is 200
                                              width: 150,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: maindishes[index]
                                                              ['image'] !=
                                                          null
                                                      ? NetworkImage(
                                                          'https://homekitchen1.herokuapp.com/upload/${maindishes[index]['image']}')
                                                      : AssetImage(
                                                          "assets/images/food.png"),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Product title and price
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          child: SizedBox(
                                            height: 136,
                                            // our image take 200 width, thats why we set out total width - 200
                                            width: size.width - 200,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Spacer(),

                                                Directionality(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              maindishes[index][
                                                                          'name'] !=
                                                                      null
                                                                  ? maindishes[
                                                                          index]
                                                                      ['name']
                                                                  : '',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      18.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Color(
                                                                      0xFF153e90))),
                                                          Text(
                                                              maindishes[index][
                                                                          'size'] !=
                                                                      null
                                                                  ? maindishes[index]
                                                                          [
                                                                          'size']
                                                                      .toString()
                                                                  : "",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Color(
                                                                      0xFF01a9b4))),
                                                          Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    maindishes[index][
                                                                                'price'] !=
                                                                            null
                                                                        ? maindishes[index][
                                                                                'price']
                                                                            .toString()
                                                                        : "",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15.0,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Color(
                                                                            0xFF01a9b4))),
                                                              ]),
                                                        ])),

                                                // it use the available space
                                                Spacer(),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        kDefaultPadding *
                                                            0.7, // 30 padding
                                                    vertical: kDefaultPadding /
                                                        5, // 5 top and bottom
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: kSecondaryColor,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(22),
                                                      topRight:
                                                          Radius.circular(22),
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
                                );
                              })
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: getProportionateScreenHeight(56),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: kPrimaryColor,
                    onPressed: () {
                      askingfocooker();
                      createChatroomandstart();
                    },
                    child: Text(
                      ' طلب الطباخ والتحدث ',
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(18),
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
