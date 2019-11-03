import 'package:flutter/material.dart';
import 'package:app/utils/database_helper.dart';
import 'package:app/models/medicine.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:app/utils/global.dart';
//import 'package:app/main.dart';
//import 'package:app/ui/home.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return new Stack(
      children: <Widget>[
        new Container(
          decoration: BoxDecoration(
            color: Colors.amber,
          ),
        ),
        HistoryList(),
      ],
    );
  }
}

class HistoryList extends StatefulWidget {
  HistoryList({Key key, this.title}) : super(key: key);
  final String title;

  @override
  ListHistoryByDay createState() => ListHistoryByDay();
}

class ListHistoryByDay extends State<HistoryList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Medicine> sunList, monList, tueList, wedList, thuList, friList, satList;
  DateTime today = DateTime.now();
  List<int> dayIndex = new List<int>();

  @override
  Widget build(BuildContext context) {
    updateListView();
    updateHistoryView();
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, int position) {
          return historyList(dayIndex[position]);
        },
      ),
    );
  }

  void updateHistoryView() {
    int x = dayReturner();
    int j = 0;
    while (j < 7) {
      if (x == 0) {
        x = 7;
      }
      dayIndex.add(x);
      x--;
      j++;
    }
  }

  int dayReturner() {
    String temp = "${DateFormat('EEEE').format(today).toLowerCase()}";
    switch (temp) {
      case 'sunday':
        return 1;
      case 'monday':
        return 2;
      case 'tuesday':
        return 3;
      case 'wednesday':
        return 4;
      case 'thursday':
        return 5;
      case 'friday':
        return 6;
      case 'saturday':
        return 7;
    }
  }

  Widget historyList(int x) {
    List<Medicine> temp = new List<Medicine>();
    String day;
    switch (x) {
      case 1:
        day = "Sunday";
        temp = sunList;
        break;
      case 2:
        day = "Monday"; temp = monList;
        break;
      case 3:
        day = "Tuesday"; temp =tueList;
        break;
      case 4:
        day = "Wednesday"; temp = wedList;
        break;
      case 5:
        day = "Thursday"; temp = thuList;
        break;
      case 6:
        day = "Friday"; temp =friList;
        break;
      case 7:
        day = "Saturday"; temp =satList;
        break;
    }
    return medThisDay(day, temp, Colors.amber);

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
