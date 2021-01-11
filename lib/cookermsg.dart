import 'package:flutter/material.dart';
import 'package:homecook/services/CookerService.dart';
import './services/Database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homecook/menucooker.dart';
import './chat.dart';

class Cookermsg extends StatefulWidget {
  @override
  _CookermsgState createState() => _CookermsgState();
}

class _CookermsgState extends State<Cookermsg> {
  var user;
  String myname;
  String mytoken;
  getme() async {
    var response2 = await CookerService().getcooker();
    setState(() {
      user = response2;
      myname = user['name'];
      mytoken = user['token'];

      print(user);
      print(user['name']);
    });
    getUserInfogetChats();
  }

  @override
  void initState() {
    super.initState();
    getme();
  }

  Stream chatRooms;
  String UserId;
  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                      userName: snapshot.data.documents[index].data['names'][1]
                          .toString(),
                      chatRoomId:
                          snapshot.data.documents[index].data["chatRoomId"],
                      UserId: snapshot.data.documents[index].data['ids'][1]);
                })
            : Container();
      },
    );
  }

  getUserInfogetChats() async {
    DatabaseMethods().getUserChats(myname).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print(
            "we got the data + ${chatRooms.toString()} this is name  ${myname}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('رسائلي')),
        backgroundColor: Color(0xFF153e90),
      ),
      endDrawer: Menucooker(),
      body: Container(
        child: chatRoomsList(),
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  final String UserId;

  ChatRoomsTile({this.userName, @required this.chatRoomId, this.UserId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Chat(chatRoomId, UserId)));
      },
      child: Container(
        color: Colors.grey,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(30)),
              child: Text(userName.substring(0, 1),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              width: 12,
            ),
            Text(userName,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w300))
          ],
        ),
      ),
    );
  }
}
