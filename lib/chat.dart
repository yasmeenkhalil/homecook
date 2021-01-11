import 'package:flutter/material.dart';
import 'package:homecook/appBarMain.dart';
import './services/Database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import './services/CookerService.dart';
import './menucooker.dart';

class Chat extends StatefulWidget {
  var chatRoomId;
  var UserId;
  bool ok;
  Chat(this.chatRoomId, this.UserId);
  @override
  _ChatState createState() => _ChatState(this.chatRoomId, this.UserId);
}

FirebaseMessaging _messagetoken = new FirebaseMessaging();
DatabaseMethods databaseMethods = new DatabaseMethods();
Stream chatmessageStream;
String mytoken;

TextEditingController _message = new TextEditingController();

class _ChatState extends State<Chat> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getaskingfocooker();
    getme();

    _messagetoken.getToken().then((t) => {
          setState(() {
            mytoken = t;
            print('mytoken' + mytoken);
          })
        });

    var value = databaseMethods.getconversationmessage(chatRoomId);
    setState(() {
      chatmessageStream = value;
    });
  }

  askingfocooker() async {
    Map<String, dynamic> data = {
      "asking": true,
      "UserId": UserId,
    };
    var response = await CookerService().askingforcooker(data);
  }

  var user;
  String myname;
  String mytoken;
  String cookerId;
  getme() async {
    var response2 = await CookerService().getcooker();
    setState(() {
      user = response2;
      myname = user['name'];
      mytoken = user['token'];
      cookerId = user['_id'];

      print(user);
      print(user['name']);
    });
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
                      snapshot.data.documents[index].data['sendby'] == myname);
                },
              )
            : Container();
      },
    );
  }

  sendMessage() {
    Map<String, dynamic> messageMap = {
      'message': _message.text,
      'sendby': myname,
      'time': DateTime.now().microsecondsSinceEpoch,
      'token': mytoken
    };
    databaseMethods.addconversationMessage(chatRoomId, messageMap);
    _message.text = "";
  }

  getaskingfocooker() async {
    var response = await CookerService().getaskingforcooker(UserId);

    setState(() {
      print(response);
      widget.ok = response['asking'];
    });
  }

  var chatRoomId;
  var UserId;
  _ChatState(this.chatRoomId, this.UserId);
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
                ],
              ),
            ),
          ),
        ),
        endDrawer: Menucooker(),
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
                                        height: 40,
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
                          : Center(
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 16),
                                  alignment: Alignment.bottomCenter,
                                  child: Column(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: Text(
                                          "أتعهد بأن يتم طبخ الذبيحة خلال المدة المتفق عليها وعدم التأخير وفي حال التأخير سوف يتم خصم30% من قيمة الطبخ",
                                          style: TextStyle(
                                            fontSize: 30,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 50,
                                        child: FlatButton(
                                          onPressed: () {
                                            askingfocooker();
                                            getaskingfocooker();
                                            this.initState();
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          color: Colors.grey,
                                          child: Text(
                                            "موافق",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            )
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
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}
