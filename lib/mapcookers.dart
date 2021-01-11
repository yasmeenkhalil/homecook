import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import './appBarMain.dart';
import './services/CookerService.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:homecook/product/products_screen.dart';

class Mapcookers extends StatefulWidget {
  var Specialization, cont, controller2, t, dateTime, newt;
  Mapcookers(this.Specialization, this.cont, this.controller2, this.t,
      this.dateTime, this.newt);

  @override
  _MapcookersState createState() =>
      _MapcookersState(Specialization, cont, controller2, t, dateTime, newt);
}

List cookers = [];

class _MapcookersState extends State<Mapcookers> {
  var Specialization, cont, controller2, t, dateTime, newt;
  _MapcookersState(this.Specialization, this.cont, this.controller2, this.t,
      this.dateTime, this.newt);
  getcookers() async {
    var response = await CookerService().getcookers();

    setState(() {
      cookers = response;
      print(cookers);
      cookers.forEach((element) {
        allMarkers.add(Marker(
            markerId: MarkerId(element['_id']),
            draggable: false,
            infoWindow: InfoWindow(title: element['name']),
            position: LatLng(element['lat'], element['lng'])));
      });
    });
    setState(() {
      allMarkers = allMarkers;
    });
  }

  PageController _pageController;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcookers();

    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onscroll);
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.subscribeToTopic('topic');
  }

  int prevPage;
  void _onscroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      movecamera();
    }
  }

  _cookerList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
            child: SizedBox(
          height: Curves.easeInOut.transform(value) * 140.0,
          width: Curves.easeInOut.transform(value) * 350.0,
          child: widget,
        ));
      },
      child: InkWell(
        onTap: () {
          print(controller2);
          print(t.toString());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ProductsScreen(cookers[index]['_id'],
                      Specialization, cont, controller2, t, dateTime, newt)));
        },
        child: Stack(
          children: [
            Center(
                child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    height: 200.0,
                    width: 289.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black54,
                              offset: Offset(0.0, 4.0),
                              blurRadius: 10.0)
                        ]),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Column(
                          children: [
                            Container(
                              height: 20.0,
                              width: 20.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      topLeft: Radius.circular(10.0)),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/online.png'),
                                      fit: BoxFit.contain)),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              cookers[index]['name'],
                              style: TextStyle(
                                  color: Color(0xFF153e90), fontSize: 18),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            RatingBarIndicator(
                              rating: cookers[index]['Rating'].toDouble(),
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 28.0,
                              direction: Axis.horizontal,
                            ),
                            // Column(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Text(cookers[index]['name']),
                            //     Text(cookers[index]['name']),
                            //     Text(cookers[index]['name']),
                            //     Text(cookers[index]['name']),
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    )))
          ],
        ),
      ),
    );
  }

  List<Marker> allMarkers = [];
  List<Marker> markers = [];
  GoogleMapController _controller;
  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: currentPosition != null
                ? GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          currentPosition.latitude, currentPosition.longitude),
                      zoom: 16.0,
                    ),
                    onMapCreated: mapCreated,
                    mapType: MapType.normal,
                    markers: Set.from(allMarkers),
                  )
                : Center(child: CircularProgressIndicator()),
          ),
          Positioned(
              bottom: 20.0,
              child: Container(
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  itemCount: cookers.length > 0 ? cookers.length : 0,
                  controller: _pageController,
                  itemBuilder: (BuildContext context, int index) {
                    return _cookerList(index);
                  },
                ),
              ))
        ],
      ),
    );
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  movecamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
          cookers[_pageController.page.toInt()]['lat'],
          cookers[_pageController.page.toInt()]['lng'],
        ),
        zoom: 16.0,
        bearing: 45.0,
        tilt: 45.0)));
  }
}
