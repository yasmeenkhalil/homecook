import 'package:flutter/material.dart';
import 'package:homecook/constants.dart';
import 'package:homecook/models/product.dart';
import '../../services/CookerService.dart';
import '../../services/MaindishService.dart';
import '../../services/Seconddish.dart';

import 'product_image.dart';
import '../../providers/cardItem.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  final id;

  const Body(this.id);

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
    getmaindish();
  }

  var maindishe;
  getmaindish() async {
    var response2 = await MaindishesService().getdishe(id);
    setState(() {
      maindishe = response2;
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
      child: maindishe != null
          ? SingleChildScrollView(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
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
                              tag: 'yas',
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding),
                                height: 200,
                                // imae is square but we add extra 20 + 20 padding thats why width is 200
                                width: 200,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: maindishe['image'] != null
                                        ? NetworkImage(
                                            'https://homekitchen1.herokuapp.com/upload/${maindishe['image']}')
                                        : AssetImage("assets/images/food.png"),
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
                              child: Text(maindishe['kindId']['name'],
                                  style: TextStyle(
                                      color: Color(0xFF153e90), fontSize: 30)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: kDefaultPadding / 2),
                            child: Text(
                              maindishe['detailes'],
                              style: TextStyle(
                                  color: Colors.blueAccent[700], fontSize: 19),
                            ),
                          ),
                          SizedBox(height: kDefaultPadding * 2),
                        ],
                      ),
                    ),
                    SizedBox(height: kDefaultPadding * 4),
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

                          Text("يتم اضافة الطبق الرئيسى من الصفحة الأولى ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
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

  void addToCart(context, product) {
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    product.pQuantity = _quantity;
    bool exist = false;
    var productsInCart = cartItem.maindishes;
    for (var productInCart in productsInCart) {
      if (productInCart.kindId == product.pName) {
        exist = true;
      }
    }
    if (exist) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('you\'ve added this item before'),
      ));
    } else {
      cartItem.addProduct(product);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Added to Cart'),
      ));
    }
  }
}
