import 'package:flutter/material.dart';
import 'package:app/utils/database_helper.dart';
import 'package:app/models/medicine.dart';
import 'package:sqflite/sqflite.dart';
import 'package:app/utils/global.dart';
//import 'package:app/main.dart';
//import 'package:app/ui/home.dart';


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

    return Container(
      child: ListView(
        children: <Widget>[
          Container(height:10),
          medThisDay("Sunday", sunList, context),
          medThisDay("Monday", monList, context),
          medThisDay("Tuesday", tueList, context),
          medThisDay("Wednesday", wedList, context),
          medThisDay("Thursday", thuList, context),
          medThisDay("Friday", friList, context),
          medThisDay("Saturday", satList, context),
        ],
      ),
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

