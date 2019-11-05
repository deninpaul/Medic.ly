import 'package:app/utils/global.dart';
import 'package:app/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:app/models/medicine.dart';
import 'package:flutter/rendering.dart';
import 'package:sqflite/sqflite.dart';

//==============================================================================
class EditMedPage extends StatefulWidget {
  EditMedPage(
      {Key key,
      this.title,
      this.medname,
      this.fullList,
      this.medicon,
      this.medtitle})
      : super(key: key);
  final String title;
  final String medname;
  String medicon;
  String medtitle;
  List<Medicine> fullList;

  @override
  EditMedPageState createState() =>
      EditMedPageState(medname: medname, medicon: medicon, medtitle: medtitle);
}

//==============================================================================
class EditMedPageState extends State<EditMedPage> {
  EditMedPageState({Key key, this.medname, this.medicon, this.medtitle});
  String medname;
  String medicon;
  int count = 0;
  String medtitle;
  List<Medicine> sunList, monList, tueList, wedList, thuList, friList, satList;
  List<bool> daySelected = [false, false, false, false, false, false, false];
  List<String> day = [
    'sunday',
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday'
  ];
  List<String> images = [
    'assets/images/tablet.png',
    'assets/images/pill.png',
    'assets/images/bottle.png',
    'assets/images/drops.png',
    'assets/images/lotion.png',
    'assets/images/syringe.png',
    'assets/images/inhaler.png'
  ];
  TimeOfDay _time = new TimeOfDay.now();
  DatabaseHelper databaseHelper = DatabaseHelper();
  Medicine med = new Medicine();

  TextEditingController titleController = TextEditingController();
  TextEditingController medNameController = TextEditingController();

  RoundedRectangleBorder _shape = new RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(100)),
      side: BorderSide(color: Colors.black, width: 1));

  @override
  Widget build(BuildContext context) {
    updateAllView();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context, false),
          color: Colors.black,
        ),
        elevation: 7,
        backgroundColor: Colors.amber,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Card(
            margin: EdgeInsets.only(bottom: 15),
            elevation: 5,
            color: Colors.amber,
            child: Container(
              padding: EdgeInsets.all(10),
              height: 270,
              alignment: Alignment.center,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      height: 150,
                      margin: EdgeInsets.only(top: 15),
                      child: Image.asset(medicon),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            new BoxShadow(
                                color: Colors.black38,
                                blurRadius: 5,
                                offset: Offset(0, 2))
                          ]),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(medname,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700)),
                    ),
                    Text(medtitle,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                  ]),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                dayListTime("Sunday", sunList, context),
                dayListTime("Monday", monList, context),
                dayListTime("Tuesday", tueList, context),
                dayListTime("Wednesday", wedList, context),
                dayListTime("Thursday", thuList, context),
                dayListTime("Friday", friList, context),
                dayListTime("Saturday", satList, context),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20, bottom: 30, top: 10, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              debugPrint("Save button clicked");
                              moveToLastScreen();
                            });
                          },
                          child: Text(
                            "Delete",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat'),
                          ),
                          elevation: 2,
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                        ),
                        height: 50,
                        padding: EdgeInsets.only(right: 20),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                          child: FlatButton(
                            onPressed: () => moveToLastScreen(),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Montserrat'),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                side:
                                    BorderSide(color: Colors.amber, width: 3)),
                          ),
                          height: 50,
                          padding: EdgeInsets.only(right: 20)),
                      flex: 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget dayListTime(String day, List<Medicine> dayList, BuildContext context) {
    return Container(
        width: 400,
        child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    day,
                    style:
                        (TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
                  ),
                  ListView.builder(
                      itemCount: dayList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, int position) {
                        if (dayList[position].medName == medname)
                          return Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                            child: Container(
                              height: 60,
                              width: 200,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 30),
                              child: Text(
                                timeDisplay(dayList[position].time),
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                              ),
                            ),
                          );
                        else
                          return Container(
                            height: 0,
                          );
                      }),
                ]),
          ),
        ));
  }

  Future<Null> selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    if (picked != null) {
      print('Time Selected: ${_time.toString()}');
      setState(() {
        _time = picked;
        med.time = (_time.hour < 12)
            ? "0${_time.hour}:${_time.minute}"
            : "${_time.hour}:${_time.minute}";
      });
    }
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void updateAllView() {
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
