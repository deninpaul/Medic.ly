//import 'package:app/models/medicine.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:app/ui/history.dart';
import 'package:app/ui/medlist.dart';
import 'package:flutter/material.dart';
import 'package:app/ui/home.dart';
import 'package:app/ui/medlist.dart';
import 'package:flutter/rendering.dart';
import 'package:app/ui/showMedicine.dart';
import 'package:app/ui/history.dart';
import 'package:app/utils/global.dart';
//import 'package:app/ui/newReminder.dart';
//import 'package:path/path.dart';
//import 'package:sqflite/sqflite.dart';
//import 'package:app/ui/newReminder.dart';
//import 'package:app/models/medicine.dart';

void main() async {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyAppState());
  }
}

class MyAppState extends StatefulWidget {
  MyAppState({Key key, this.title}) : super(key: key);
  final String title;

  @override
  MyAppBar createState() => MyAppBar();
}

class MyAppBar extends State<MyAppState> with SingleTickerProviderStateMixin {
  TabController tabcontroller;
  Color appbarcolor = Colors.amber;
  int intialpageIndex = 1;
  int currentpage = 1;
  Color homepageColor;

  @override
  void initState() {
    super.initState();
    tabcontroller = new TabController(length: 3, vsync: this, initialIndex: 1);
    tabcontroller.addListener(listener);
    homePageIndex = 0;
  }

  @override
  void dispose() {
    tabcontroller.dispose();
    super.dispose();
  }

  void listener() {
    setState(() {
      currentpage = tabcontroller.index;
      debugPrint("$currentpage");
    });
  }

  bool onWillPop() {
    if (tabcontroller.index == 1) {
      return true;
    } else {
      tabcontroller.animateTo(
        intialpageIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      return false;
    }
  }

  _updateMyTitle(Color _tempcolor) {
    setState(() {
      appbarcolor = _tempcolor;
      homepageColor = appbarcolor;
    });
  }

  // void _handleTabChange(){
  //   setState(() {
  //     if(appbarcolor == Colors.white)
  //       pageChanger(0); debugPrint("runs");
  //   });
  // }

  Color appbarColorChanger() {
    setState(() {
      if (currentpage == 1) {
        appbarcolor = homepageColor;
      } else {
        appbarcolor = Colors.amber;
      }
    });

    return appbarcolor;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.amber,
            fontFamily: 'Montserrat',
            backgroundColor: Colors.amber),
        title: 'Home Page',
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: Container(
                    padding: EdgeInsets.only(left: 18, top: 5),
                    child: Text("medic.ly",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 25))),
                elevation: 0,
                backgroundColor: Colors.amber,
                bottom: TabBar(
                  tabs: [
                    tabBarText('Meds', TextAlign.left),
                    tabBarText('Home', TextAlign.center),
                    tabBarText('History', TextAlign.right),
                  ],
                  indicatorColor: Colors.black,
                  indicatorWeight: 3,
                  controller: tabcontroller,
                ),
              ),
              body: TabBarView(
                controller: tabcontroller,
                children: <Widget>[
                  WillPopScope(
                      onWillPop: () => Future.sync(onWillPop),
                      child: Medicines()),
                  HomePage(
                    parentAction: _updateMyTitle,
                  ),
                  WillPopScope(
                      onWillPop: () => Future.sync(onWillPop),
                      child: History()),
                ],
              ),
            )));
  }

  Tab tabBarText(String title, TextAlign align) {
    return Tab(
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
        textAlign: align,
      ),
    );
  }
}
