import 'package:flutter/material.dart';
import 'package:app/ui/newReminder.dart';
import 'package:app/utils/database_helper.dart';
import 'package:app/models/medicine.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:app/utils/global.dart';
//import 'package:app/ui/medlist.dart';
//import 'package:app/ui/medlist.dart';


class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: Text(
              "Coming Soon :P",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat'),
            ),
            alignment: AlignmentDirectional.center,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

class NextMed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NextMedState();
  }
}

class NextMedState extends StatefulWidget {
  NextMedState({Key key, this.title}) : super(key: key);
  final String title;

  @override
  ShowNextMed createState() => ShowNextMed();
}

class ShowNextMed extends State<NextMedState> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Medicine> todayList;
  DateTime today = DateTime.now();
  Medicine nextMed;
  String nexttitle = " ", nexttime = " ", nextmedName = " ";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    updateListView();
    return Stack(children: <Widget>[
      Container(
        decoration: new BoxDecoration(
          color: Colors.amber,
        ),
      ),
      Container(
        height: size.height/2,
        color: Colors.amber,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child:  Text(
                nexttitle != " " ?"Next": " ",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.only(bottom: 10),
              width: size.width,
            ),
            Container(
                width: 160,
                height: 160,
                child: nexttitle != " "
                    ? RaisedButton(
                        elevation: 5,
                        color: Colors.white,
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                      )
                    : null),
            Container(
              child: Text(
                nexttime == " " ? " " : timeDisplay(nexttime),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.only(top: 10, bottom: 0),
              width: size.width,
            ),
            Container(
              child: Text(
                nexttitle,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.only(top: 0, bottom: 15),
              width: size.width,
            ),
          ],
        ),
      ),
    ]);
  }

  void updateListView() {
    if (todayList == null) {
      todayList = List<Medicine>();

      final Future<Database> dbFuture = databaseHelper.initializeDatabase();
      dbFuture.then((database) {
        Future<List<Medicine>> noteListFuture =
            databaseHelper.getNoteList('${DateFormat('EEEE').format(today)}');
        noteListFuture.then((noteList) {
          setState(() {
            this.todayList = noteList;
            if (this.todayList != null) {
              this.nextMed = this.todayList[0];
              nextmedName = this.nextMed.medName;
              nexttime = this.nextMed.time;
              nexttitle = this.nextMed.title;
            }
          });
        });
      });
    }
  }
}

class BottomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomDrawerState();
  }
}

class BottomDrawerState extends StatefulWidget {
  BottomDrawerState({Key key, this.title}) : super(key: key);
  final String title;

  @override
  ListMedToday createState() => ListMedToday();
}

class ListMedToday extends State<BottomDrawerState> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Medicine> todayList;
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    updateListView();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        new Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(50.0),
                    topRight: const Radius.circular(50.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 20,
                  ),
                ]),
            width: size.width,
            height: 270.0,
            child: Column(
              children: <Widget>[
                Container(height: 20),
                new Container(
                  child: medThisDay("Todays", todayList),
                  padding: EdgeInsets.all(0.0),
                ),
              ],
            )),
        Container(
          height: 20,
          color: Colors.white,
        )
      ],
    );
  }

  void updateListView() {
    if (todayList == null) {
      todayList = List<Medicine>();

      final Future<Database> dbFuture = databaseHelper.initializeDatabase();
      dbFuture.then((database) {
        Future<List<Medicine>> noteListFuture =
            databaseHelper.getNoteList('${DateFormat('EEEE').format(today)}');
        noteListFuture.then((noteList) {
          setState(() {
            this.todayList = noteList;
          });
        });
      });
    }
  }
}

Widget appBarMenu(appcolor) {
  return Container(
    color: appcolor,
    padding: EdgeInsets.only(top: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Text(
              "Meds",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Text(
              "Home",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Text(
              "Profile",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget currentPageIndicator(double deviceWidth, MainAxisAlignment lineAlign) {
  return Row(mainAxisAlignment: lineAlign, children: <Widget>[
    Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      width: (deviceWidth - 10) / 3,
      height: 10,
      child: Card(
        color: Colors.black,
        elevation: 5,
      ),
    ),
  ]);
}

Widget bottomFABs(BuildContext context) {
  return Align(
    alignment: AlignmentDirectional.bottomEnd,
    child: Container(
      margin: EdgeInsets.all(20),
      height: 70,
      width: 70,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewMedPage()),
          );
        },
        child: Icon(Icons.add, size: 50,),
        foregroundColor: Colors.white,
        elevation: 6,
      ),
    ),
  );
}
