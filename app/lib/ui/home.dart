import 'package:flutter/material.dart';

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
            height: 300.0,
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


Row bottomFABs() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    mainAxisSize: MainAxisSize.max,
    children: <Widget>[
      Expanded(
        child: Container(
            margin: EdgeInsets.fromLTRB(15, 10, 0, 10),
            width: 200,
            height: 70,
            color: Colors.transparent,
            child: RaisedButton(
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search',
                            icon: Icon(Icons.search)),
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      padding: EdgeInsets.only(left: 10),
                    ),
                  ],
                ),
              ),
              onPressed: () {},
              elevation: 5,
              color: Colors.white,
              hoverColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  side: BorderSide(color: Colors.amber, width: 3)),
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
            elevation: 5,
          ),
        ),
        flex: 2,
      )
    ],
  );
}
