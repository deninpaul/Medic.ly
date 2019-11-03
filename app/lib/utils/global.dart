import 'package:app/models/medicine.dart';
import 'package:flutter/material.dart';

int homePageIndex;
PageController globalDrawercontroller = PageController(initialPage: 0);
void pageChanger(int caseChecker) {
  if (caseChecker == 0) {
    globalDrawercontroller.nextPage(
        duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
    debugPrint("moved front");
  } else {
    globalDrawercontroller.previousPage(
        duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
    debugPrint("moved back");
  }
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

Widget medThisDay(String dayofweek, List<Medicine> daylist,
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
            child: getMedListView(daylist),
            color: cardColor,
            elevation: 0,
          ),
        ),
      ],
    ),
  );
}

ListView getMedListView(List<Medicine> daylist) {
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
          onPressed: () {},
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
                    child: Text(daylist[position].title,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                    flex: 3,
                  ),
                ],
              )),
        ),
      );
    },
  );
}
