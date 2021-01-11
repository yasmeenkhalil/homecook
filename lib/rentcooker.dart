import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homecook/mapcookers.dart';
import 'package:homecook/menuuser.dart';
import './services/KindService.dart';
import './menuuser.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class Rentcooker extends StatefulWidget {
  @override
  _RentcookerState createState() => _RentcookerState();
}

String Specialization;

TextEditingController _controller = TextEditingController();
TextEditingController _controller2 = TextEditingController();

class _RentcookerState extends State<Rentcooker> {
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay picked;
  List UserType = [];
  var t;
  String formattedTimeOfDay;
  String formattedTimeOfDay2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = "1";
    _controller2.text = "1";
    t = 50;
    getkinds();
  }

  bool online = true;
  var id;
  getkinds() async {
    var kinds = await KindService().getKind();
    this.UserType = kinds;
    setState(() {
      print(kinds);
    });
  }

  var _dateTime;
  Widget hourMinute12H() {
    return new TimePickerSpinner(
      is24HourMode: false,
      onTimeChange: (time) {
        setState(() {
          _dateTime = time;
          newTime = _dateTime != null
              ? _dateTime.subtract(new Duration(hours: 3))
              : "";
          newt = " ${newTime.hour.toString()}-${newTime.minute.toString()}";
        });
      },
    );
  }

  String newt;
  DateTime newTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
        endDrawer: Menuuser(),
        body: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: Text("طريقة طبخ الذبيحة ",
                          style: TextStyle(
                              fontSize: 18, color: Color(0xFF153e90))),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.65,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF01a9b4),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        // padding: const EdgeInsets.only(right: 20.0, left: 20),

                        child: Center(
                          child: DropdownButton<String>(
                            hint: Text(
                              "          اختر طريقة الطبخ                   ",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            value: Specialization,
                            isDense: true,
                            onChanged: (value) {
                              setState(() {
                                Specialization = value;
                              });
                            },
                            items: UserType.map((user) {
                              return DropdownMenuItem<String>(
                                  value: user['name'],
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      user['name'],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ));
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Text("عدد الذبايح",
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xFF153e90))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 60.0, top: 10),
                          child: Center(
                            child: Container(
                              width: 90.0,
                              foregroundDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(
                                  color: Color(0xFF01a9b4),
                                  width: 1.0,
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(8.0),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                      ),
                                      controller: _controller,
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                        decimal: false,
                                        signed: true,
                                      ),
                                      inputFormatters: <TextInputFormatter>[
                                        WhitelistingTextInputFormatter
                                            .digitsOnly
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 50.0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                width: 0.5,
                                              ),
                                            ),
                                          ),
                                          child: InkWell(
                                            child: Icon(
                                              Icons.arrow_drop_up,
                                              size: 18.0,
                                            ),
                                            onTap: () {
                                              int currentValue =
                                                  int.parse(_controller.text);
                                              setState(() {
                                                currentValue++;
                                                _controller.text = (currentValue)
                                                    .toString(); // incrementing value
                                              });
                                            },
                                          ),
                                        ),
                                        InkWell(
                                          child: Icon(
                                            Icons.arrow_drop_down,
                                            size: 18.0,
                                          ),
                                          onTap: () {
                                            int currentValue =
                                                int.parse(_controller.text);
                                            setState(() {
                                              print("Setting state");
                                              currentValue--;
                                              _controller.text = (currentValue >
                                                          0
                                                      ? currentValue
                                                      : 0)
                                                  .toString(); // decrementing value
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Text("عدد الصحون",
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xFF153e90))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 60.0, top: 10),
                          child: Center(
                            child: Container(
                              width: 90.0,
                              foregroundDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(
                                  color: Color(0xFF01a9b4),
                                  width: 1.0,
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(8.0),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                      ),
                                      controller: _controller2,
                                      onChanged: (value) {
                                        setState(() {
                                          t = 50 * int.parse(_controller2.text);
                                        });
                                      },
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                        decimal: false,
                                        signed: true,
                                      ),
                                      inputFormatters: <TextInputFormatter>[
                                        WhitelistingTextInputFormatter
                                            .digitsOnly
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 50.0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                width: 0.5,
                                              ),
                                            ),
                                          ),
                                          child: InkWell(
                                            child: Icon(
                                              Icons.arrow_drop_up,
                                              size: 18.0,
                                            ),
                                            onTap: () {
                                              int currentValue =
                                                  int.parse(_controller2.text);
                                              setState(() {
                                                currentValue++;
                                                _controller2.text =
                                                    (currentValue).toString();
                                                t = 50 *
                                                    int.parse(_controller2
                                                        .text); // incrementing value
                                              });
                                            },
                                          ),
                                        ),
                                        InkWell(
                                          child: Icon(
                                            Icons.arrow_drop_down,
                                            size: 18.0,
                                          ),
                                          onTap: () {
                                            int currentValue =
                                                int.parse(_controller2.text);
                                            setState(() {
                                              print("Setting state");
                                              currentValue--;
                                              _controller2.text =
                                                  (currentValue > 0
                                                          ? currentValue
                                                          : 0)
                                                      .toString();
                                              // decrementing value
                                              t = 50 *
                                                  int.parse(_controller2.text);
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 50, top: 10, bottom: 10),
                      child: Text("قيمة التأمين",
                          style: TextStyle(
                              fontSize: 18, color: Color(0xFF153e90))),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 60),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          border: Border.all(
                            color: Color(0xFF01a9b4),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Center(
                          child: Text(
                            (t.toString()),
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, right: 50),
                      child: Text("وقت استلام الذبيحة ",
                          style: TextStyle(
                              fontSize: 18, color: Color(0xFF153e90))),
                    ),
                  ],
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    color: Colors.white,
                    child: hourMinute12H()),
                // Row(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(right: 60),
                //       child: Container(
                //         height: 50,
                //         width: MediaQuery.of(context).size.width * 0.6,
                //         decoration: BoxDecoration(
                //           color: Colors.grey[50],
                //           border: Border.all(
                //             color: Color(0xFF01a9b4),
                //             width: 1.0,
                //           ),
                //           borderRadius: BorderRadius.circular(5.0),
                //         ),
                //         child: Center(
                //           child: Text(formattedTimeOfDay != null
                //               ? formattedTimeOfDay
                //               : ""),
                //         ),
                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: () async {
                //         TimeOfDay picked = await showTimePicker(
                //           context: context,
                //           initialTime: TimeOfDay.now(),
                //           builder: (BuildContext context, Widget child) {
                //             return MediaQuery(
                //               data: MediaQuery.of(context)
                //                   .copyWith(alwaysUse24HourFormat: true),
                //               child: child,
                //             );
                //           },
                //         );
                //         setState(() {
                //           _time = picked;
                //           final localizations =
                //               MaterialLocalizations.of(context);

                //           formattedTimeOfDay =
                //               localizations.formatTimeOfDay(_time);
                //           print(picked);
                //           final now = new DateTime.now();
                //           final time = DateTime(now.year, now.month, now.day,
                //               _time.hour, _time.minute);
                //           newTime = time != null
                //               ? time.subtract(new Duration(hours: 3))
                //               : 0;
                //           TimeOfDay newtimes = TimeOfDay.fromDateTime(newTime);
                //           formattedTimeOfDay2 =
                //               localizations.formatTimeOfDay(newtimes);
                //         });
                //       },
                //       child: Icon(
                //         Icons.alarm,
                //         color: Color(0xFF153e90),
                //       ),
                //     ),
                //   ],
                // ),
                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, right: 40),
                      child: Text(
                          "وقت تسليم الذبيحة للطباخ قبل الاستلام ب3 ساعات",
                          style: TextStyle(
                              fontSize: 18, color: Color(0xFF153e90))),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 60),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          border: Border.all(
                            color: Color(0xFF01a9b4),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Center(
                          child: Text((newt != null ? newt.toString() : "")),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: CheckboxListTile(
                    title: Text("الظهور للخريطة كمتاح"),
                    value: online,
                    onChanged: (newValue) {
                      setState(() {
                        online = !online;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    print(_controller2.text);
                    print(t.toString());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Mapcookers(
                                Specialization,
                                _controller.text,
                                _controller2.text,
                                t,
                                _dateTime,
                                newt)));
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Color(0xFF153e90),
                      border: Border.all(color: Colors.blue),
                    ),
                    child: Center(
                      child: Text('طلب',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ));
  }

  Widget hourMinute12HCustomStyle() {
    return new TimePickerSpinner(
      // itemWidth: 30.0,
      alignment: Alignment.topCenter,
      time: DateTime.now(),
      // isShowSeconds: true,
      is24HourMode: false,
      normalTextStyle: TextStyle(fontSize: 24, color: Colors.blue),
      highlightedTextStyle: TextStyle(fontSize: 24, color: Colors.black),
      spacing: 5,
      itemHeight: 40,
      isForce2Digits: true,
      minutesInterval: 1,
      onTimeChange: (time) {
        setState(() {
          // _dateTime = time;
        });
      },
    );
  }
}

extension TimeOfDayExtension on TimeOfDay {
  TimeOfDay addHour(int hour) {
    return this.replacing(hour: this.hour - hour, minute: this.minute);
  }
}
