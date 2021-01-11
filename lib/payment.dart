import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import './services/UserService.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Payment extends StatefulWidget {
  var price, cont, controller2, t, dateTime, newt, seconddish;
  String cookerId, Specialization;
  Payment(this.price, this.Specialization, this.cont, this.controller2, this.t,
      this.dateTime, this.newt, this.cookerId, this.seconddish);
  @override
  _PaymentState createState() => _PaymentState(price, Specialization, cont,
      controller2, t, dateTime, newt, cookerId, seconddish);
}

class _PaymentState extends State<Payment> {
  var price, cont, controller2, t, dateTime, newt, seconddish;
  String cookerId, Specialization;
  _PaymentState(this.price, this.Specialization, this.cont, this.controller2,
      this.t, this.dateTime, this.newt, this.cookerId, this.seconddish);
  var user;
  var userId;

  getuser() async {
    var response = await UserService().getuser();
    setState(() {
      user = response;
      userId = user['_id'];
    });
    print(user);
  }

  final formatCurrency = new NumberFormat.simpleCurrency();
  @override
  void initState() {
    String v = price.toString() + '00';
    print(v);
    price = int.parse(v);
    print(price);
    getuser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userId != null
          ? WebView(
              onPageFinished: (page) {
                if (page.contains('/success')) {
                  Navigator.pop(context);
                  Map<String, dynamic> data = {
                    "slicenumbers": cont,
                    "price": price,
                    "dishescount": controller2,
                    "insurance": t,
                    "starttime": dateTime.toString(),
                    "endtime": newt.toString(),
                    "UserId": userId,
                    "CookerId": cookerId,
                    "kind": Specialization,
                  };
                  var response = UserService().createsubscription(data);
                  Fluttertoast.showToast(
                      msg: "تمت عملية الدفع بنجاح",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
              initialUrl:
                  new Uri.dataFromString(_loadHTML(), mimeType: 'text/html')
                      .toString(),
              javascriptMode: JavascriptMode.unrestricted,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  String _loadHTML() {
    return '''
      <html>
        <body onload="document.f.submit();">
          <form id="f" name="f" method="post" action="https://homekitchen1.herokuapp.com/pay">
            <input type="hidden" name="price" value="$price" />
         
           
            </form>
        </body>
      </html>
    ''';
  }
}
