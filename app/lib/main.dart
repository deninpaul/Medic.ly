//import 'package:app/models/medicine.dart';
import 'package:app/ui/medlist.dart';
import 'package:flutter/material.dart';
import 'package:app/ui/home.dart';
import 'package:app/ui/medlist.dart';
//import 'package:app/ui/newReminder.dart';
//import 'package:path/path.dart';
//import 'package:sqflite/sqflite.dart';

void main() async {
  runApp(MyApp());
}

PageController globalcontroller;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  Color _appBarColor = Colors.amber;
  PageController controller = PageController(initialPage: 0);

  void onPageChanged(int page) {
    Color _tempColor;
    switch (page) {
      case 0:
        _tempColor = Colors.amber;
        break;
      case 1:
        _tempColor = Colors.white;
        break;
    }
    setState(() {
      this._appBarColor = _tempColor;
    });
  }

  bool onWillPop() {
    if (globalcontroller.page.round() == globalcontroller.initialPage) {
      return true;
    } else {
      globalcontroller.previousPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    globalcontroller = controller;
    return new MaterialApp(
        title: 'Home',
        theme: ThemeData(primarySwatch: Colors.amber, fontFamily: 'Montserrat'),
        home: new Scaffold(
          drawer: Drawer(),
          appBar: new AppBar(
            elevation: 0,
            backgroundColor: _appBarColor,
          ),
          body: Stack(children: <Widget>[
            NextMed(),
            PageView(
              children: <Widget>[
                BottomDrawer(),
                //MedList()
                WillPopScope(
                    onWillPop: () => Future.sync(onWillPop), child: MedList()),
              ],
              scrollDirection: Axis.vertical,
              onPageChanged: onPageChanged,
              controller: globalcontroller,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomFABs(),
            )
          ]),
        ));
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

void pageChanger() {
  globalcontroller.previousPage(
      duration: Duration(milliseconds: 1000), curve: Curves.easeInOut);
  globalcontroller.nextPage(
      duration: Duration(milliseconds: 500), curve: Curves.easeInOut);   
}
