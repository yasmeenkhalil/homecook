import 'package:flutter/material.dart';
import 'package:homecook/menucooker.dart';
import 'package:homecook/appBarMain.dart';
import './services/MaindishService.dart';

class Myservices extends StatefulWidget {
  @override
  _MyservicesState createState() => _MyservicesState();
}

class _MyservicesState extends State<Myservices> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdishes();
  }

  var dishes = [];

  getdishes() async {
    var response = await MaindishesService().getdishes();
    if (mounted) {
      setState(() {
        dishes = response;
      });
    }
    print(dishes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF153e90),
      appBar: new AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xFF153e90),
        title: Text(''),
      ),
      endDrawer: Menucooker(),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  "  أطباقي الرئيسية",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
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
                                        _buildFoodItem(
                                            "https://homekitchen1.herokuapp.com/upload/${dishes[index]['image']}",
                                            dishes[index]['kindId'] != null
                                                ? dishes[index]['kindId']
                                                    ['name']
                                                : "",
                                            dishes[index]['detailes'] != null
                                                ? dishes[index]['detailes']
                                                : ''),
                                      ]));
                                    }),
                              )
                            : Center(
                                child: Text(
                                    'لإضافة أطباق توجه الى اضافة طبق رئيسي'),
                              ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFoodItem(String imgPath, String foodName, String fooddetail) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 0),
        child: InkWell(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => DetailsPage(heroTag: imgPath, foodName: foodName, foodPrice: price)
              // ));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(children: [
                  Hero(
                      tag: imgPath,
                      child: Container(
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
                      )),
                  SizedBox(width: 20.0),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(foodName,
                            style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF153e90))),
                        Container(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: 180.0,
                              maxWidth: 180.0,
                              minHeight: 30.0,
                              maxHeight: 200.0,
                            ),
                            child: Text(fooddetail,
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF01a9b4))),
                          ),
                        )
                      ]),
                ])),
              ],
            )));
  }
}
