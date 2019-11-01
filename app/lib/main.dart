//import 'package:app/models/medicine.dart';
import 'dart:convert';

import 'package:app/ui/medlist.dart';
import 'package:flutter/material.dart';
import 'package:app/ui/home.dart';
import 'package:app/ui/medlist.dart';
import 'package:flutter/rendering.dart';
import 'package:app/ui/showMedicine.dart';
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

  @override
  void initState() {
    super.initState();
    tabcontroller = new TabController(length: 3, vsync: this, initialIndex: 1);
    setState(() {});
  }

  @override
  void dispose() {
    tabcontroller.dispose();
    super.dispose();
  }

  _updateMyTitle(Color _tempcolor) {
    setState(() {
      appbarcolor = _tempcolor;
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

  // void _handleTabChange(){
  //   setState(() {
  //     if(appbarcolor == Colors.white)
  //       pageChanger(0); debugPrint("runs");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.amber, fontFamily: 'Montserrat'),
        title: 'Home Page',
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: Container(padding: EdgeInsets.only(left:18, top: 5),child: Text("elder.ly", style: TextStyle(fontFamily: 'Montserrat', fontWeight:FontWeight.w700, fontSize: 25 ))),
                elevation: 0,
                backgroundColor: appbarcolor,
                bottom: TabBar(
                  tabs: [
                    Tab(
                      child: Text(
                        "Meds",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                        child: Text("Home",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center)),
                    Tab(
                        child: Text(
                      "Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    )),
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
                    onWillPop: () => Future.sync(onWillPop), child: Medicines()),
                  HomePage(
                    parentAction: _updateMyTitle,
                  ),
                  WillPopScope(
                    onWillPop: () => Future.sync(onWillPop), child: Profile()),
                ],
              ),
            )));
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.parentAction}) : super(key: key);
  final String title;
  final ValueChanged<Color> parentAction;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  MainAxisAlignment menuIndicatorAlign = MainAxisAlignment.center;

  @override
  bool get wantKeepAlive => true;

  void onDrawerPageChanged(int page) {
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
      widget.parentAction(_tempColor);
      print("Color Changed");
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
          NextMed(),
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
          bottomFABs(context),
        ])));
  }
}

void pageChanger({int caseChecker = 0}) {
  globalDrawercontroller.previousPage(
      duration: Duration(milliseconds: 1000), curve: Curves.easeInOut);
  debugPrint("moved back");
  // if (caseChecker == 1) {
  //   globalDrawercontroller.nextPage(
  //       duration: Duration(milliseconds: 600), curve: Curves.easeInOut);
  //   debugPrint("moved front");
  // }
}
