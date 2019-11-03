import 'package:flutter/material.dart';
import 'package:app/ui/newReminder.dart';
import 'package:app/utils/database_helper.dart';
import 'package:app/models/medicine.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:app/utils/global.dart';
import 'medlist.dart';
//import 'package:app/ui/medlist.dart';
//import 'package:app/ui/medlist.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.parentAction}) : super(key: key);
  final String title;
  final ValueChanged<Color> parentAction;
  @override
  HomePageState createState() => HomePageState();
}

GlobalKey<ShowNextMed> keyChild1 = GlobalKey();

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  MainAxisAlignment menuIndicatorAlign = MainAxisAlignment.center;

  @override
  bool get wantKeepAlive => true;

  void initState(){
    super.initState();
    homePageIndex =0;
  }

  void onDrawerPageChanged(int page) {
    Color _tempColor;
    switch (page) {
      case 0:
        _tempColor = Colors.amber;
        keyChild1.currentState.updateNext();
        break;
      case 1:
        _tempColor = Colors.white;
        break;
    }
    setState(() {
      globalAppBarColor = _tempColor;
      homePageIndex = page;
      widget.parentAction(_tempColor);
      print("Color Changed to ${_tempColor}");
    });
  }

  bool onWillPop() {
    if (globalDrawercontroller.page.round() ==
        globalDrawercontroller.initialPage) {
      return true;
    } else {
      globalDrawercontroller.previousPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialApp(
        title: 'Home',
        theme: ThemeData(primarySwatch: Colors.amber, fontFamily: 'Montserrat'),
        home: new Scaffold(
            body: Stack(children: <Widget>[
          NextMed(key: keyChild1),
          PageView(
            children: <Widget>[
              BottomDrawer(),
              WillPopScope(
                  onWillPop: () => Future.sync(onWillPop), child: MedList()),
            ],
            scrollDirection: Axis.vertical,
            onPageChanged: onDrawerPageChanged,
            controller: globalDrawercontroller,
          ),
        ])));
  }
}


class NextMed extends StatefulWidget {
  NextMed({Key key, this.title}) : super(key: key);
  final String title;

  @override
  ShowNextMed createState() => ShowNextMed();
}

class ShowNextMed extends State<NextMed> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Medicine> todayList;
  DateTime today = DateTime.now();
  Medicine nextMed;
  String nexttitle = " ", nexttime = " ", nextmedName = " ", nextmedIcon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    updateListView();
    updateNext();
    return Stack(children: <Widget>[
      Container(
        decoration: new BoxDecoration(
          color: Colors.amber,
        ),
      ),
      Container(
        height: size.height / 2,
        color: Colors.amber,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                nexttitle != " " ? "Next" : " ",
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
                        child: Image.asset(
                          nextmedIcon,
                          fit: BoxFit.fill,
                        ),
                        color: Colors.black,
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
          });
        });
      });
    }
  }

  void updateNext() {
    if (this.todayList.length != 0) {
      this.nextMed = this.todayList[0];
      nextmedName = this.nextMed.medName;
      nexttime = this.nextMed.time;
      nexttitle = this.nextMed.title;
      nextmedIcon = this.nextMed.medIcon;
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

class ListMedToday extends State<BottomDrawerState>
    with AutomaticKeepAliveClientMixin {
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
                  child: medThisDay("Todays", todayList,context),
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

  @override
  bool get wantKeepAlive => false;
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
  return Container(
    height: 70,
    width: 70,
    child: FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewMedPage()),
        );
      },
      child: Icon(
        Icons.add,
        size: 50,
      ),
      foregroundColor: Colors.white,
      elevation: 6,
    ),
  );
}
