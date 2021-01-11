import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:homecook/constants.dart';
import 'package:homecook/models/product.dart';
import 'package:homecook/appBarMain.dart';
import 'components/body.dart';

class DetailssecondScreen extends StatelessWidget {
  final id;

  const DetailssecondScreen(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Body(this.id),
    );
  }
}
