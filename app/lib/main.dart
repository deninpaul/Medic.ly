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
          bottomNavigationBar: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Container(
                    margin: EdgeInsets.fromLTRB(15, 10, 0, 10),
                    width: 200,
                    height: 70,
                    color: Colors.white,
                    child: RaisedButton(
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter a search term'),
                      ),
                      onPressed: () {},
                      elevation: 10,
                      hoverColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                    )),
                flex: 5,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(20),
                  height: 70,
                  width: 70,
                  child: FloatingActionButton(
                    onPressed: () {},
                    child: Icon(Icons.add),
                    foregroundColor: Colors.white,
                    elevation: 10,
                  ),
                ),
                flex: 2,
              )
            ],
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
          ]),
        ));
  }
}
