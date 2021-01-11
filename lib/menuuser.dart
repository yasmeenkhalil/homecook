import 'package:flutter/material.dart';
import './services/UserService.dart';
import './loginas.dart';
import './subscriptionuser.dart';
import './rentcooker.dart';
import './PrivacyPolicy.dart';

class Menuuser extends StatefulWidget {
  @override
  _MenuuserState createState() => _MenuuserState();
}

class _MenuuserState extends State<Menuuser> {
  @override
  void initState() {
    getuser();
    super.initState();
  }

  var user;
  getuser() async {
    var response = await UserService().getuser();
    if (mounted) {
      setState(() {
        user = response;
      });
    }
    print(user);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                  child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/user.png'),
                          fit: BoxFit.cover,
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  user != null
                      ? Text(user['name'] != null ? user['name'] : "",
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))
                      : Center(child: CircularProgressIndicator()),
                ],
              )),
              decoration: BoxDecoration(
                color: Color(0xFF153e90),
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.home, size: 25, color: Color(0xFF153e90)),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('طلب طباخ',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF153e90))),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Rentcooker()));
              },
            ),
            Divider(
              color: Color(0xFF153e90),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.food_bank, size: 20, color: Color(0xFF153e90)),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('الطلبات',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF153e90))),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => UserSubscriptions()));
              },
            ),
            Divider(
              color: Color(0xFF153e90),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.file_copy_rounded,
                      size: 20, color: Color(0xFF153e90)),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('الشروط والأحكام',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF153e90))),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => PrivacyPolicy()));
              },
            ),
            Divider(
              color: Color(0xFF153e90),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.logout, size: 20, color: Color(0xFF153e90)),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('تسجيل الخروج ',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF153e90))),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => Loginas(),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
