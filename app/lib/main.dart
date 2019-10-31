import 'package:app/models/medicine.dart';
import 'package:app/ui/medlist.dart';
import 'package:flutter/material.dart';
import 'package:app/ui/home.dart';
import 'package:app/ui/medlist.dart';
import 'package:flutter/rendering.dart';
//import 'package:app/ui/newReminder.dart';
//import 'package:path/path.dart';
//import 'package:sqflite/sqflite.dart';
//import 'package:app/ui/newReminder.dart';
//import 'package:app/models/medicine.dart';

void main() async {
  runApp(MyApp());
}

PageController globalDrawercontroller = PageController(initialPage: 0);
PageController globalMenucontroller = PageController(initialPage: 1);
Color globalAppBarColor = Colors.amber;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Home Page',
        home: PageView(
          children: <Widget>[Medicines(), HomePage(), Profile()],
          scrollDirection: Axis.horizontal,
          controller: globalMenucontroller,
        ));
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  
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
      globalAppBarColor = _tempColor;
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
          appBar: AppBar(
            elevation: 0,
            backgroundColor: globalAppBarColor,
            title: Container(
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: appBarMenu(globalAppBarColor)),
                  currentPageIndicator(size.width),
                ],
              ),
            ),
          ),
          body: Stack(children: <Widget>[
            NextMed(),
            PageView(
              children: <Widget>[
                BottomDrawer(),
                WillPopScope(
                    onWillPop: () => Future.sync(onWillPop), child: MedList()),
              ],
              scrollDirection: Axis.vertical,
              onPageChanged: onPageChanged,
              controller: globalDrawercontroller,
            ),
            bottomFABs(context),
          ]),
        ));
  }
  }



void pageChanger(int caseChecker) {
  globalDrawercontroller.previousPage(
      duration: Duration(milliseconds: 1000), curve: Curves.easeInOut);
  debugPrint("moved back");
  if (caseChecker == 1) {
    globalDrawercontroller.nextPage(
        duration: Duration(milliseconds: 600), curve: Curves.easeInOut);
    debugPrint("moved front");
  }
}