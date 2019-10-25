import 'package:flutter/material.dart';

class BottomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
            height: 220.0,
            child: Column(
              children: <Widget>[
                new Container(
                  child: Text(
                    "Todays",
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
    );
  }
}

class NextMed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String nextMed = "Diabetes";

    return Stack(children: <Widget>[
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
    ]);
  }
}
