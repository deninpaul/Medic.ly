import 'package:app/main.dart';
import 'package:app/ui/home.dart';
import 'package:flutter/material.dart';

class MedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return new Stack(
      children: <Widget>[
        new Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
        MedListPage(),
      ],
    );
  }
}

class MedListPage extends StatefulWidget {
  MedListPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  ListMedByDay createState() => ListMedByDay();
}

class ListMedByDay extends State<MedListPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        medThisDay("Sunday"),
        medThisDay("Monday"),
        medThisDay("Tuesday"),
        medThisDay("Wednesday"),
        medThisDay("Thursday"),
        medThisDay("Friday"),
        medThisDay("Saturday"),
        Container(
          height: 100,
        ),
      ],
    );
  }
}

Widget medThisDay(String dayofweek) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 330,
          child: Text(
            "$dayofweek",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        new Container(
          margin: EdgeInsets.all(25),
          height: 150,
          child: Card(
            child: getListView(),
            elevation: 30,
          ),

        ),
      ],
    ),
  );
}

ListView getListView() {
  return ListView(
    scrollDirection: Axis.horizontal,
    children: <Widget>[
      Container(
        width: 150.0,
        color: Colors.red,
      ),
      Container(
        width: 150.0,
        color: Colors.blue,
      ),
      Container(
        width: 150.0,
        color: Colors.green,
      ),
      Container(
        width: 150.0,
        color: Colors.yellow,
      ),
      Container(
        width: 150.0,
        color: Colors.orange,
      ),
    ],
  );
}
