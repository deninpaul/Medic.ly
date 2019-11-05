import 'package:app/main.dart';
import 'package:app/models/medicine.dart';
import 'package:app/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:app/ui/home.dart';
import 'package:intl/intl.dart';

PageController globalMenucontroller = PageController(initialPage: 1);
Color globalAppBarColor = Colors.amber;
int homePageIndex;
DateTime initialDate;

PageController globalDrawercontroller = PageController(initialPage: 0);
void pageChanger(int caseChecker, [int ms = 400]) {
  if (caseChecker == 0) {
    globalDrawercontroller.nextPage(
        duration: Duration(milliseconds: ms), curve: Curves.easeInOut);
    debugPrint("moved front");
  } else {
    globalDrawercontroller.previousPage(
        duration: Duration(milliseconds: ms), curve: Curves.easeInOut);
    debugPrint("moved back");
  }
}

TextStyle formTitle() {
  return TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontFamily: 'Montserrat');
}

TextStyle formBox() {
  return TextStyle(
      fontSize: 26,
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontFamily: 'Montserrat');
}

String timeDisplay(String timegiven) {
  var timesplitted = timegiven.split(':');
  if (int.parse(timesplitted[0]) > 12) {
    if (int.parse(timesplitted[1]) < 10) {
      return "${int.parse(timesplitted[0]) - 12}:0${int.parse(timesplitted[1])}pm";
    } else {
      return "${int.parse(timesplitted[0]) - 12}:${int.parse(timesplitted[1])}pm";
    }
  } else {
    if (int.parse(timesplitted[1]) < 10) {
      return "${int.parse(timesplitted[0])}:0${int.parse(timesplitted[1])}am";
    } else {
      return "${int.parse(timesplitted[0])}:${int.parse(timesplitted[1])}am";
    }
  }
}

Widget medThisDay(
    String dayofweek, List<Medicine> daylist, BuildContext context,
    [Color cardColor = Colors.white]) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 330,
          child: Text(
            "$dayofweek",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        new Container(
          margin: EdgeInsets.only(left: 5, right: 5, bottom: 10, top: 10),
          height: 180,
          child: Card(
            child: getMedListView(daylist, context, dayofweek.toLowerCase()),
            color: cardColor,
            elevation: 0,
          ),
        ),
      ],
    ),
  );
}

ListView getMedListView(
    List<Medicine> daylist, BuildContext context, String weekDay) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: daylist.length,
    itemBuilder: (context, int position) {
      return Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        child: RaisedButton(
          color: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          onPressed: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) => ShowDetails(
                      day: daylist[position],
                      context: context,
                      weekDay: weekDay,
                    ));
          },
          child: Container(
              width: 110,
              height: 150,
              padding: EdgeInsets.only(bottom: 5, top: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Image.asset(daylist[position].medIcon),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            new BoxShadow(
                                color: Colors.black38,
                                blurRadius: 5,
                                offset: Offset(0, 2))
                          ]),
                    ),
                    flex: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    child: Text(timeDisplay(daylist[position].time),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700)),
                    flex: 3,
                  ),
                  Expanded(
                    child: Container(
                      child: Text(daylist[position].medName,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                    ),
                    flex: 3,
                  ),
                ],
              )),
        ),
      );
    },
  );
}

class ShowDetails extends StatefulWidget {
  ShowDetails(
      {Key key, this.title, this.day, this.weekDay, BuildContext context})
      : super(key: key);
  final String title;
  final String weekDay;
  final Medicine day;

  @override
  ShowDetailsState createState() =>
      ShowDetailsState(day: day, weekday: weekDay);
}

class ShowDetailsState extends State<ShowDetails> {
  ShowDetailsState({Key key, this.day, this.weekday, BuildContext context});
  DatabaseHelper databaseHelper = DatabaseHelper();
  Medicine day;
  String weekday;
  var time, hour, minute;
  DateTime today;

  TimeOfDay _time;

  // TimeOfDay _time = TimeOfDay(hour: hour, minute: minute);
  void initState() {
    super.initState();
    time = day.time.split(':');
    hour = int.parse(time[0]);
    minute = int.parse(time[1]);
    today = DateTime.now();
    _time = TimeOfDay(hour: hour, minute: minute);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Colors.amber, width: 5)),
        child: Container(
          height: 600,
          padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Container(
                      child: Image.asset(day.medIcon),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            new BoxShadow(
                                color: Colors.black38,
                                blurRadius: 5,
                                offset: Offset(0, 2))
                          ]),
                    ),
                    flex: 4),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      timeDisplay(day.time),
                      style: TextStyle(
                          fontSize: 27,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        day.medName,
                        style: TextStyle(
                            fontSize: 29,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    flex: 1),
                Expanded(
                    child: Container(
                      child: Text(
                        day.title,
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    flex: 1),
                Expanded(
                  child: Container(
                    width: 220,
                    padding: EdgeInsets.only(bottom: 10),
                    child: GestureDetector(
                      child: RaisedButton(
                        color: Colors.red,
                        elevation: 5,
                        child: Text("Delete",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600)),
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      onLongPress: () {
                        deleteRem(context);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Container(
                    width: 220,
                    padding: EdgeInsets.only(bottom: 5),
                    child: RaisedButton(
                      color: Colors.amber,
                      elevation: 5,
                      child: Text("Change Time",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600)),
                      onPressed: () {
                        selectTime(context);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  flex: 2,
                ),
                Expanded(
                    child: Container(
                      width: 220,
                      padding: EdgeInsets.only(bottom: 10),
                      child: RaisedButton(
                        color: Colors.white,
                        elevation: 5,
                        child: Text("OK",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: BorderSide(color: Colors.amber, width: 5),
                        ),
                      ),
                    ),
                    flex: 2),
                Expanded(
                    child: Container(
                      child: Text(
                        "Long Press to Delete",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    flex: 1),
              ],
            ),
          ),
        ));
  }

  Future<Null> selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    if (picked != null) {
      print('Time Selected: ${_time.toString()}');
      setState(() {
        _time = picked;
        day.time = (_time.hour < 12)
            ? "0${_time.hour}:${_time.minute}"
            : "${_time.hour}:${_time.minute}";
      });
    }
    int result;
    debugPrint('$homePageIndex');

    pageChanger(homePageIndex);
    if (homePageIndex == 0)
      setState(() {
        homePageIndex = 1;
      });
    else if (homePageIndex == 1)
      setState(() {
        homePageIndex = 0;
      });

    result = await databaseHelper.updateNote(day,
        weekday == 'todays' ? '${DateFormat('EEEE').format(today)}' : weekday);
    if (result != 0)
      debugPrint('Update successful');
    else
      debugPrint('Update not succesful');
  }

  Future<Null> deleteRem(BuildContext context) async {
    int result;
    result = await databaseHelper.deleteNote(day.id,
        weekday == 'todays' ? '${DateFormat('EEEE').format(today)}' : weekday);
    if (result != 0)
      debugPrint('Delete successful');
    else
      debugPrint('Delete not succesful');

    pageChanger(homePageIndex);
    if (homePageIndex == 0)
      setState(() {
        homePageIndex = 1;
      });
    else if (homePageIndex == 1)
      setState(() {
        homePageIndex = 0;
      });
  }
}
