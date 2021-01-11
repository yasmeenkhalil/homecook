import 'package:flutter/material.dart';
import 'package:homecook/models/seconddish.dart';
import './providers/cardItem.dart';
import 'package:provider/provider.dart';
import './models/maindish.dart';
import './payment.dart';

class CartScreen extends StatefulWidget {
  var Specialization, cont, controller2, t, dateTime, newt;
  String cookerId;
  CartScreen(this.Specialization, this.cont, this.controller2, this.t,
      this.dateTime, this.newt, this.cookerId);
  var price1;
  var price2;

  @override
  _CartScreenState createState() => _CartScreenState(
      Specialization, cont, controller2, t, dateTime, newt, cookerId);
}

class _CartScreenState extends State<CartScreen> {
  var Specialization, cont, controller2, t, dateTime, newt;
  String cookerId;
  _CartScreenState(this.Specialization, this.cont, this.controller2, this.t,
      this.dateTime, this.newt, this.cookerId);
  List<Secondish> seconddish;
  @override
  void initState() {
    widget.price1 = (250 * int.parse(cont));

    super.initState();
  }

  var count = 0;
  @override
  Widget build(BuildContext context) {
    seconddish = Provider.of<CartItem>(context).seconddishs;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Color(0xFF153e90),
        elevation: 0,
        title: Text(
          'مشترياتي',
          style: TextStyle(color: Colors.white),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: <Widget>[
            widget.Specialization != null
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                        top: MediaQuery.of(context).size.height * 0.019,
                        bottom: MediaQuery.of(context).size.height * 0.07),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                    ),
                    child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            widget.Specialization.toString(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "عدد الذبايح",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    widget.cont.toString(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10),
                              Column(
                                children: [
                                  Text(
                                    "السعر",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    widget.price1.toString(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "عدد الصحون",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      controller2.toString(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Column(
                                  children: [
                                    Text(
                                      "قيمة التأمين",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      (t.toString()),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ])
                        ]))
                : Container(
                    height: 80,
                    child: Text('لم تطلب طبق رئيسي'),
                  ),
            SizedBox(height: 10.0),
            LayoutBuilder(builder: (context, constrains) {
              if (seconddish.isNotEmpty) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: GestureDetector(
                          onTapUp: (details) {
                            // showCustomMenu(details, context, seconddish[index]);
                          },
                          child: Column(
                            children: [
                              Container(
                                height: screenHeight * .15,
                                child: Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: screenHeight * .15 / 2,
                                      backgroundImage: NetworkImage(
                                          'https://homekitchen1.herokuapp.com/upload/${seconddish[index].image}'),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                seconddish[index].name,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                seconddish[index]
                                                    .price
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Text(
                                            seconddish[index]
                                                .pQuantity
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 40),
                                          child: Text(
                                            (seconddish[index].pQuantity *
                                                        seconddish[index].price)
                                                    .toString() +
                                                'ريال ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: seconddish.length,
                  ),
                );
              } else {
                return Container(
                  height: 50,
                );
              }
            }),
            Specialization != null || seconddish != null
                ? Builder(
                    builder: (context) => ButtonTheme(
                      minWidth: screenWidth,
                      height: screenHeight * .08,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10))),
                        onPressed: () {
                          seconddish.forEach((element) =>
                              count += (element.pQuantity * element.price));
                          var price = widget.price1 + t + count;
                          print(price);
                          if (price != null) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => Payment(
                                        price,
                                        Specialization,
                                        cont,
                                        controller2,
                                        t,
                                        dateTime,
                                        newt,
                                        cookerId,
                                        seconddish)));
                          }
                        },
                        child: Text(
                          'دفع',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        color: Color(0xFF153e90),
                      ),
                    ),
                  )
                : Text('')
          ],
        ),
      ),
    );
  }
}
