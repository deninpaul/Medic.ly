import 'package:app/main.dart';
import 'package:app/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:app/utils/database_helper.dart';
import 'package:app/models/medicine.dart';
import 'package:sqflite/sqflite.dart';

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
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Medicine> sunList, monList, tueList, wedList, thuList, friList, satList;

  @override
  Widget build(BuildContext context) {
    updateListView();

    return ListView(
      children: <Widget>[
        medThisDay("Sunday", sunList),
        medThisDay("Monday", monList),
        medThisDay("Tuesday", tueList),
        medThisDay("Wednesday", wedList),
        medThisDay("Thursday", thuList),
        medThisDay("Friday", friList),
        medThisDay("Saturday", satList),
        Container(
          height: 100,
        ),
      ],
    );
  }

  void updateListView() {
    if (sunList == null) {
      sunList = List<Medicine>();
      final Future<Database> dbFuture = databaseHelper.initializeDatabase();
      dbFuture.then((database) {
        Future<List<Medicine>> noteListFuture =
            databaseHelper.getNoteList('sunday');
        noteListFuture.then((noteList) {
          setState(() {
            this.sunList = noteList;
          });
        });
      });
    }

    if (monList == null) {
      monList = List<Medicine>();
      final Future<Database> dbFuture = databaseHelper.initializeDatabase();
      dbFuture.then((database) {
        Future<List<Medicine>> noteListFuture =
            databaseHelper.getNoteList('monday');
        noteListFuture.then((noteList) {
          setState(() {
            this.monList = noteList;
          });
        });
      });
    }

    if (tueList == null) {
      tueList = List<Medicine>();
      final Future<Database> dbFuture = databaseHelper.initializeDatabase();
      dbFuture.then((database) {
        Future<List<Medicine>> noteListFuture =
            databaseHelper.getNoteList('tuesday');
        noteListFuture.then((noteList) {
          setState(() {
            this.tueList = noteList;
          });
        });
      });
    }

    if (wedList == null) {
      wedList = List<Medicine>();
      final Future<Database> dbFuture = databaseHelper.initializeDatabase();
      dbFuture.then((database) {
        Future<List<Medicine>> noteListFuture =
            databaseHelper.getNoteList('wednesday');
        noteListFuture.then((noteList) {
          setState(() {
            this.wedList = noteList;
          });
        });
      });
    }

    if (thuList == null) {
      thuList = List<Medicine>();
      final Future<Database> dbFuture = databaseHelper.initializeDatabase();
      dbFuture.then((database) {
        Future<List<Medicine>> noteListFuture =
            databaseHelper.getNoteList('thursday');
        noteListFuture.then((noteList) {
          setState(() {
            this.thuList = noteList;
          });
        });
      });
    }

    if (friList == null) {
      friList = List<Medicine>();
      final Future<Database> dbFuture = databaseHelper.initializeDatabase();
      dbFuture.then((database) {
        Future<List<Medicine>> noteListFuture =
            databaseHelper.getNoteList('friday');
        noteListFuture.then((noteList) {
          setState(() {
            this.friList = noteList;
          });
        });
      });
    }

    if (satList == null) {
      satList = List<Medicine>();
      final Future<Database> dbFuture = databaseHelper.initializeDatabase();
      dbFuture.then((database) {
        Future<List<Medicine>> noteListFuture =
            databaseHelper.getNoteList('saturday');
        noteListFuture.then((noteList) {
          setState(() {
            this.satList = noteList;
          });
        });
      });
    }
  }
}

Widget medThisDay(String dayofweek, List<Medicine> daylist) {
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
          margin: EdgeInsets.only(left: 5, right: 5, bottom: 10, top: 10),
          height: 180,
          child: Card(
            child: getMedListView(daylist),
            elevation: 0,
          ),
        ),
      ],
    ),
  );
}

ListView getMedListView(List<Medicine> daylist) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: daylist.length,
    itemBuilder: (context, int position) {
      return Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        child: RaisedButton(
          color: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          onPressed: () {},
          child: Container(
              width: 110,
              height: 150,
              padding: EdgeInsets.only(bottom: 5, top: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            new BoxShadow(
                                color: Colors.black38,
                                blurRadius: 5,
                                offset: Offset(0, 2))
                          ]),
                    ),
                    flex: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    child: Text(timeDisplay(daylist[position].time),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700)),
                    flex: 3,
                  ),
                  Expanded(
                    child: Text(daylist[position].title,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                    flex: 3,
                  ),
                ],
              )),
        ),
      );
    },
  );
}
