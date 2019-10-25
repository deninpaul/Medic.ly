import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new MyHomePage(),
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
    final size = MediaQuery.of(context).size;
    String nextMed = "Diabetes";

    return new MaterialApp(
      title: 'Hello',
      theme: ThemeData(primarySwatch: Colors.amber, fontFamily: 'Montserrat'),
      home: new Scaffold(
          drawer: Drawer(),
          appBar: AppBar(
            elevation: 0.0,
          ),
          body: Stack(children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                color: Colors.amber,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Container(
                  child: Container(
                    child: Text(
                      nextMed,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.all(50),
                    width: size.width,
                  ),
                )
              ],
            ),
            Column(
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
                    height: 300.0,
                    child: Column(
                      children: <Widget>[
                        new Container(
                          child: Text(
                            "Today",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 30.0,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          padding: EdgeInsets.all(30.0),
                          width: size.width,
                        ),
                      ],
                    )),
              ],
            )
          ])),
    );
  }
}
