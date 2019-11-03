//import 'package:app/models/medicine.dart';
import 'dart:convert';

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
  runApp(MyApp());
}

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
  int currentpage = 1;
  Color homepageColor;

  @override
  void initState() {
    super.initState();
    tabcontroller = new TabController(length: 3, vsync: this, initialIndex: 1);
    tabcontroller.addListener(listener);
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
      if (currentpage == 1)
        appbarcolor = homepageColor;
      else
        appbarcolor = Colors.amber;
    });

    return appbarcolor;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.amber, fontFamily: 'Montserrat'),
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
                backgroundColor: appbarColorChanger(),
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
              floatingActionButton: bottomFABs(context),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
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


