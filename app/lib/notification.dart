import 'package:flutter/material.dart';
import 'package:app/utils/database_helper.dart';
import 'package:app/models/medicine.dart';
import 'package:sqflite/sqflite.dart';
import 'package:app/utils/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notification extends StatefulWidget {
  Notification({Key key, this.title}) : super(key: key);
  final String title;

  @override
  NotificationState createState() => NotificationState();
}

class NotificationState extends State<Notification> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Medicine> sunList, monList, tueList, wedList, thuList, friList, satList;

  @override
  Widget build(BuildContext context) {
    updateListView();
    if (sunList == null &&
        monList == null &&
        tueList == null &&
        wedList == null &&
        thuList == null &&
        friList == null &&
        satList == null) {
      initialDate = DateTime.now();
      _initialDateChange();
    }else {
      _getInitialDate();
    }
    return null;
  }

  _initialDateChange() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('initialDate', "${initialDate.microsecondsSinceEpoch}");
  }
  _getInitialDate() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String initialDateString = prefs.getString('initialDate');
    initialDate = DateTime(int.parse(initialDateString));
    debugPrint("$initialDate");
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
