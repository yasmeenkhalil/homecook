import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:homecook/constants.dart';
import '../appBarMain.dart';
import 'components/body.dart';

class ProductsScreen extends StatelessWidget {
  var id;
  var Specialization, cont, controller2, t, dateTime, newt;
  ProductsScreen(this.id, this.Specialization, this.cont, this.controller2,
      this.t, this.dateTime, this.newt);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Body(id, Specialization, cont, controller2, t, dateTime, newt),
    );
  }
}
