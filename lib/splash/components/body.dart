import 'package:flutter/material.dart';
import 'package:homecook/constants.dart';
import 'package:homecook/main.dart';
import 'package:homecook/size_config.dart';
import 'package:homecook/loginas.dart';
import '../../services/CookerService.dart';
// This is the best practice
import '../components/splash_content.dart';
import './default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;

  @override
  void initState() {
    getimages();
    super.initState();
  }

  String image1;
  String image2;
  String image3;
  List<Map<String, String>> splashData = [];
  var images;
  getimages() async {
    var response = await CookerService().getimages();
    setState(() {
      print(response);
      images = response;
      image1 = response['image1'];
      image2 = response['image2'];
      image3 = response['image3'];
      splashData = [
        {"text": "أهلا بك في الطباخ المنزلي", "image": image1},
        {"text": "نحن نساعد على ربط الطباخ المنزلى بالعملاء ", "image": image2},
        {"text": "يمكنك طلب الطباخ والدفع أونلان بكل سهولة", "image": image3},
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image:
                      "https://homekitchen1.herokuapp.com/upload/${splashData[index]['image']}",
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    DefaultButton(
                      text: "دخول",
                      press: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => Loginas()));
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? Color(0xFF153e90) : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
