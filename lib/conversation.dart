import 'package:flutter/material.dart';
import 'package:homecook/appBarMain.dart';
import 'package:homecook/services/CookerService.dart';
import 'package:homecook/services/notificationapi.dart';
import './services/Database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import './services/UserService.dart';
import './splash/components/default_button.dart';
import './card.dart';

class Conversation extends StatefulWidget {
  var chatRoomId;
  var cookerId;
  bool ok;
  var Specialization, cont, controller2, t, dateTime, newt;
  Conversation(this.chatRoomId, this.cookerId, this.Specialization, this.cont,
      this.controller2, this.t, this.dateTime, this.newt);
  @override
  _ConversationState createState() => _ConversationState(chatRoomId, cookerId,
      Specialization, cont, controller2, t, dateTime, newt);
}

FirebaseMessaging _messagetoken = new FirebaseMessaging();
DatabaseMethods databaseMethods = new DatabaseMethods();
Stream chatmessageStream;
String mytoken;
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
String token;

class _ConversationState extends State<Conversation> {
  var chatRoomId;
  String cookerId;
  var Specialization, cont, controller2, t, dateTime, newt;
  _ConversationState(this.chatRoomId, this.cookerId, this.Specialization,
      this.cont, this.controller2, this.t, this.dateTime, this.newt);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getaskingfocooker();
    getuserinfo();

    _messagetoken.getToken().then((t) => {
          setState(() {
            mytoken = t;
            print('mytoken' + mytoken);
          })
        });

    print(chatRoomId);
    var value = databaseMethods.getconversationmessage(chatRoomId);
    setState(() {
      chatmessageStream = value;
    });
  }

  var cooker;

  getcooker() async {
    var res = await CookerService().getcookerwithid(cookerId);
    setState(() {
      cooker = res;
      token = cooker['token'];
    });
  }

  var user;
  var username;
  getuserinfo() async {
    var response = await UserService().getuser();
    setState(() {
      user = response;
      username = user['name'];
    });
    _firebaseMessaging.subscribeToTopic('all');

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  Future sendNotification() async {
    final response =
        await Messaging.sendTo(body: _message.text, fcmToken: token);
  }

  Widget ChatMessageList() {
    return StreamBuilder(
      stream: chatmessageStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                      snapshot.data.documents[index].data['message'],
                      snapshot.data.documents[index].data['sendby'] ==
                          username);
                },
              )
            : Container();
      },
    );
  }

  sendMessage() {
    Map<String, dynamic> messageMap = {
      'message': _message.text,
      'sendby': username,
      'time': DateTime.now().microsecondsSinceEpoch,
      'token': mytoken
    };
    databaseMethods.addconversationMessage(chatRoomId, messageMap);
    _message.text = "";
  }

  getaskingfocooker() async {
    var response = await UserService().getaskingforcooker(cookerId);

    setState(() {
      print(response);
      widget.ok = response['asking'];
    });
  }

  TextEditingController _message = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          backgroundColor: Color(0xFF153e90),
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios)),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CartScreen(Specialization, cont,
                                    controller2, t, dateTime, newt, cookerId)));
                      },
                      child: Icon(Icons.shopping_cart))
                ],
              ),
            ),
          ),
        ),
        body: Stack(children: [
          Container(
              color: Colors.white,
              child: Stack(
                children: [
                  ChatMessageList(),
                  SizedBox(
                    height: 10,
                  ),
                  widget.ok != null
                      ? widget.ok == true
                          ? Container(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                color: Colors.grey[700],
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 16),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        sendMessage();
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              Colors.grey[800],
                                              Colors.grey[700]
                                            ]),
                                            borderRadius:
                                                BorderRadius.circular(40)),
                                        padding: EdgeInsets.all(11),
                                        child: Center(
                                          child: Image.asset(
                                              "assets/images/send.png"),
                                        ),
                                      ),
                                    ),
                                    Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Expanded(
                                        child: TextField(
                                          controller: _message,
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                              hintText: "ادخل الرسالة هنا",
                                              hintStyle: TextStyle(
                                                  color: Colors.white),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: FlatButton(
                                  onPressed: () {},
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  color: Colors.grey,
                                  child: Text(
                                    "نم طلب الطباخ بانتظار الموافقة",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ))
                      : Center(child: CircularProgressIndicator()),
                ],
              )),
        ]));
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  MessageTile(this.message, this.isSendByMe);
  @override
  Widget build(BuildContext context) {
    return isSendByMe != null
        ? Container(
            padding: EdgeInsets.only(
                left: isSendByMe ? 0 : 24, right: isSendByMe ? 24 : 0),
            width: MediaQuery.of(context).size.width,
            alignment:
                isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isSendByMe
                        ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                        : [Colors.grey, Colors.grey[400]],
                  ),
                  borderRadius: isSendByMe
                      ? BorderRadius.only(
                          topLeft: Radius.circular(23),
                          topRight: Radius.circular(23),
                          bottomLeft: Radius.circular(23))
                      : BorderRadius.only(
                          topLeft: Radius.circular(23),
                          topRight: Radius.circular(23),
                          bottomRight: Radius.circular(23))),
              child: Text(
                message,
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}
