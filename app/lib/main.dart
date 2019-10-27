import 'package:flutter/material.dart';
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
  Color _appBarColor = Colors.amber;

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

  @override
  Widget build(BuildContext context) {
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
                new BottomDrawer(),
                new MedList(),
              ],
              scrollDirection: Axis.vertical,
              onPageChanged: onPageChanged,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: bottomFABs(),
            )
          ]),
        ));
  }
}
