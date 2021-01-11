import 'package:flutter/material.dart';
import 'package:homecook/menucooker.dart';
import 'package:homecook/appBarMain.dart';
import './services/Seconddish.dart';

class Myseconddishes extends StatefulWidget {
  @override
  _MyseconddishesState createState() => _MyseconddishesState();
}

class _MyseconddishesState extends State<Myseconddishes> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdishes();
  }

  var dishes = [];
  getdishes() async {
    var response = await SeconddishService().getdishes();
    setState(() {
      dishes = response;
    });
    print(dishes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF153e90),
      appBar: new AppBar(
        title: Text('l'),
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xFF153e90),
        iconTheme: IconThemeData(color: Colors.green),
      ),
      endDrawer: Menucooker(),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Center(
                child: Text(
                  "أطباقي الجانبية",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(75)),
                    color: Colors.white),
                child: ListView(
                  primary: false,
                  padding: EdgeInsets.only(left: 25.0, right: 20.0),
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 45.0),
                        child: dishes != null
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height - 200.0,
                                child: ListView.builder(
                                    itemCount:
                                        dishes.length > 0 ? dishes.length : 0,
                                    padding: EdgeInsets.only(top: 0.0),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return SingleChildScrollView(
                                          child: Column(children: [
                                        _buildFoodItems(
                                            "http://10.0.2.2:3000/upload/${dishes[index]['image']}",
                                            dishes[index]['name'] != null
                                                ? dishes[index]['name']
                                                : "",
                                            dishes[index]['price'] != null
                                                ? dishes[index]['price']
                                                    .toString()
                                                : "",
                                            dishes[index]['size'] != null
                                                ? dishes[index]['size']
                                                : ''),
                                      ]));
                                    }),
                              )
                            : Center(
                                child: Text(
                                    'لإضافة أطباق توجه الى اضافة طبق جانبي'),
                              ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFoodItems(
      String imgPath, String foodName, String price, String foodSize) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 20.0, top: 0),
        child: InkWell(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => DetailsPage(heroTag: imgPath, foodName: foodName, foodPrice: price)
              // ));
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        child: Row(children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imgPath != null
                                  ? NetworkImage(imgPath)
                                  : AssetImage("assets/images/food.png"),
                              fit: BoxFit.cover,
                            )),
                      ),
                      SizedBox(width: 30.0),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(foodName,
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF153e90))),
                            Text(price,
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF01a9b4))),
                          ]),
                      SizedBox(width: 30.0),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(foodSize,
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF01a9b4))),
                          ]),
                    ])),
                  ],
                ),
                SizedBox(
                  height: 10,
                )
              ],
            )));
  }
}
