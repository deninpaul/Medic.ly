import 'package:flutter/material.dart';
import 'package:app/models/global.dart';
import 'package:app/ui/home.dart';
import 'package:app/ui/medlist.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Hello',
        theme: ThemeData(primarySwatch: Colors.amber, fontFamily: 'Montserrat'),
        home: new Scaffold(
          drawer: Drawer(),
          appBar: new AppBar(
            elevation: 0,
          ),
          body: Stack(children: <Widget>[
            NextMed(),
            PageView(
              children: <Widget>[
                new BottomDrawer(),
                new MedList(),
              ],
              scrollDirection: Axis.vertical,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: bottomFABs(),
            )
            
          ]),
        ));
  }
}
