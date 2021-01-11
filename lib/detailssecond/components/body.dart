import 'package:flutter/material.dart';
import 'package:homecook/constants.dart';
import 'package:homecook/models/product.dart';
import '../../services/CookerService.dart';
import '../../services/MaindishService.dart';
import '../../services/Seconddish.dart';
import '../../models/seconddish.dart';
import '../../providers/cardItem.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  final id;

  Body(this.id);

  @override
  _BodyState createState() => _BodyState(id);
}

class _BodyState extends State<Body> {
  var id;
  _BodyState(this.id);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getseconddish();
  }

  var seconddish;
  getseconddish() async {
    var response2 = await SeconddishService().getdishe(id);
    setState(() {
      seconddish = Secondish.fromJson(response2);
      print(seconddish);
    });
  }

  int _quantity = 1;
  @override
  Widget build(BuildContext context) {
    // it provide us total height and width
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small devices
    return SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: seconddish != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        decoration: BoxDecoration(
                          color: kBackgroundColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Hero(
                                tag: 'second',
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding),
                                  height: 200,
                                  // imae is square but we add extra 20 + 20 padding thats why width is 200
                                  width: 200,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: seconddish.image != null
                                          ? NetworkImage(
                                              'https://homekitchen1.herokuapp.com/upload/${seconddish.image}')
                                          : AssetImage(
                                              "assets/images/food.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: kDefaultPadding / 2),
                                child: Column(
                                  children: [
                                    Text(
                                        seconddish.name != null
                                            ? seconddish.name
                                            : "",
                                        style: TextStyle(
                                            color: Color(0xFF153e90),
                                            fontSize: 30)),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: kDefaultPadding / 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'السعر',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 25),
                                      ),
                                      Text(
                                        seconddish.price != null
                                            ? seconddish.price.toString()
                                            : "",
                                        style: TextStyle(
                                            color: Colors.blueAccent[700],
                                            fontSize: 19),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'الحجم',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 25),
                                      ),
                                      Text(
                                        seconddish.size != null
                                            ? seconddish.size.toString()
                                            : "",
                                        style: TextStyle(
                                            color: Colors.blueAccent[700],
                                            fontSize: 19),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: kDefaultPadding * 2),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipOval(
                            child: Material(
                              color: Color(0xFFFCBF1E),
                              child: GestureDetector(
                                onTap: add,
                                child: SizedBox(
                                  child: Icon(Icons.add),
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            _quantity.toString(),
                            style: TextStyle(fontSize: 50),
                          ),
                          ClipOval(
                            child: Material(
                              color: Color(0xFFFCBF1E),
                              child: GestureDetector(
                                onTap: subtract,
                                child: SizedBox(
                                  child: Icon(Icons.remove),
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.all(kDefaultPadding),
                        padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                          vertical: kDefaultPadding / 2,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFFCBF1E),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            // it will cover all available spaces

                            FlatButton.icon(
                              onPressed: () {
                                addToCart(context, seconddish);
                              },
                              icon: Icon(Icons.shopping_bag),
                              height: 20,
                              label: Text("اضافة الى السلة",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Center(child: CircularProgressIndicator()),
          ),
        ));
  }

  subtract() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        print(_quantity);
      });
    }
  }

  add() {
    setState(() {
      _quantity++;
      print(_quantity);
    });
  }

  void addToCart(context, seconddish) {
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    seconddish.pQuantity = _quantity;
    bool exist = false;
    var seconddishsInCart = cartItem.seconddishs;
    for (var seconddishInCart in seconddishsInCart) {
      if (seconddishInCart.id == seconddish.id) {
        exist = true;
      }
    }
    if (exist) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Directionality(
            textDirection: TextDirection.rtl, child: Text('لقد اضفتها مسبقا')),
        backgroundColor: Colors.green,
      ));
    } else {
      cartItem.addseconddishs(seconddish);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Directionality(
            textDirection: TextDirection.rtl,
            child: Text('تم اضافتها الى السلة بنجاح')),
        backgroundColor: Colors.green,
      ));
    }
  }
}
