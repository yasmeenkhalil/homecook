import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context, String title) {
  return AppBar(
    title: Center(child: Text(title)),
    elevation: 0.0,
    backgroundColor: Color(0xFF153e90),
  );
}
