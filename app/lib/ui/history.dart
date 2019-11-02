import 'package:flutter/material.dart';
import 'package:app/utils/database_helper.dart';
import 'package:app/models/medicine.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:app/utils/functions.dart';
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
  List<List<Medicine>> weekList = new List<List<Medicine>>();
  List<String> weekDays = new List<String>();

  @override
  Widget build(BuildContext context) {
    updateListView();
    updateHistoryView();
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, int position) {
          return medThisDay(weekDays[position], weekList[position]);
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
      historyList(x);
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

  void historyList(int x) {
    switch (x) {
      case 1:
        this.weekList.add(this.sunList);
        weekDays.add('Sunday');
        break;
      case 2:
        
        weekList.add(this.monList);
        weekDays.add('Monday');
        debugPrint("${monList[0].title}");
        debugPrint("${weekList[0].length}");
        break;
      case 3:
        weekList.add(this.tueList);
        weekDays.add('Tuesday');
        break;
      case 4:
        weekList.add(this.wedList);
        weekDays.add('Wednesday');
        break;
      case 5:
        weekList.add(this.thuList);
        weekDays.add('Thursday');
        break;
      case 6:
        weekList.add(this.friList);
        weekDays.add('Friday');
        break;
      case 7:
        weekList.add(this.satList);
        weekDays.add('Saturday');
        break;
    }
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
