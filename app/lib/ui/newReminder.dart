import 'package:app/main.dart';
import 'package:app/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:app/models/medicine.dart';
//import 'package:sqflite/sqflite.dart';
//import 'package:app/ui/medlist.dart';
//import 'package:app/ui/home.dart';

//==============================================================================
class NewMedPage extends StatefulWidget {
  NewMedPage({Key key, this.title, this.med}) : super(key: key);
  final String title;
  final Medicine med;

  @override
  NewMedPageState createState() => NewMedPageState();
}

//==============================================================================
class NewMedPageState extends State<NewMedPage> {
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
  bool iseveryday = true;
  DatabaseHelper helper = DatabaseHelper();
  Medicine med = new Medicine();

  TextEditingController titleController = TextEditingController();
  TextEditingController medNameController = TextEditingController();

  RoundedRectangleBorder _shape = new RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(100)),
      side: BorderSide(color: Colors.black, width: 1));

  void initState() {
    super.initState();
    med.time = "${_time.hour}:${_time.minute}";
  }

  void _daySelector(int i) {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      daySelected[i] = !daySelected[i];
    });
  }

  int selectedRadioTile;
  void setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  bool everythingSelected(List<bool> ls) {
    for (int i = 0; i < ls.length; i++) {
      if (ls[i] == false) return false;
    }
    return true;
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

  Expanded dayFlatButton(String dayname, int i) {
    return Expanded(
        child: Container(
      child: FlatButton(
        onPressed: () => _daySelector(i),
        color: daySelected[i] ? Colors.amber : Colors.amber[100],
        child: Text(
          dayname,
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
      ),
      padding: EdgeInsets.only(right: 5),
      margin: EdgeInsets.only(top: 15),
      height: 50,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Medicine",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat'),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context, false),
          color: Colors.black,
        ),
        elevation: 7,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            height: 30,
          ),
          Card(
              elevation: 5,
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      "Medicine Name",
                      style: formTitle(),
                      textAlign: TextAlign.left,
                    ),
                    TextField(
                      controller: medNameController,
                      onChanged: (value) {
                        debugPrint('Something changed in med Name text field');
                        updateMedName();
                      },
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.amber, width: 2)),
                          contentPadding: EdgeInsets.all(10)),
                      style: formBox(),
                    ),
                  ],
                ),
              )),
          Card(
              elevation: 5,
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      "Treatment For",
                      style: formTitle(),
                      textAlign: TextAlign.left,
                    ),
                    TextField(
                      controller: titleController,
                      onChanged: (value) {
                        debugPrint('Something Changed in treatment text field');
                        updateTitle();
                      },
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.amber, width: 2)),
                          contentPadding: EdgeInsets.all(10)),
                      style: formBox(),
                    ),
                  ],
                ),
              )),
          Card(
              elevation: 5,
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
              child: Container(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  margin: EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Medicine Type",
                            style: formTitle(),
                            textAlign: TextAlign.left,
                          ),
                          margin: EdgeInsets.only(bottom: 20, left: 10),
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Card(
                                      elevation: 5,
                                      child: RadioListTile(
                                        value: 1,
                                        groupValue: selectedRadioTile,
                                        title: Text(
                                          "Tablet",
                                          style: formBox(),
                                        ),
                                        activeColor: Colors.amber,
                                        secondary: Container(
                                          height: 45,
                                          child: Image.asset(images[0]),
                                        ),
                                        onChanged: (val) {
                                          setSelectedRadioTile(val);
                                        },
                                        selected: true,
                                      )),
                                  Card(
                                      elevation: 5,
                                      child: RadioListTile(
                                        value: 2,
                                        groupValue: selectedRadioTile,
                                        title: Text(
                                          "Pill",
                                          style: formBox(),
                                        ),
                                        activeColor: Colors.amber,
                                        secondary: Container(
                                          height: 45,
                                          child: Image.asset(images[1]),
                                        ),
                                        onChanged: (val) {
                                          setSelectedRadioTile(val);
                                        },
                                        selected: false,
                                      )),
                                  Card(
                                      elevation: 5,
                                      child: RadioListTile(
                                        value: 3,
                                        groupValue: selectedRadioTile,
                                        title: Text(
                                          "Bottle",
                                          style: formBox(),
                                        ),
                                        activeColor: Colors.amber,
                                        secondary: Container(
                                          height: 45,
                                          child: Image.asset(images[2]),
                                        ),
                                        onChanged: (val) {
                                          setSelectedRadioTile(val);
                                        },
                                        selected: true,
                                      )),
                                  Card(
                                      elevation: 5,
                                      child: RadioListTile(
                                        value: 4,
                                        groupValue: selectedRadioTile,
                                        title: Text(
                                          "Drops",
                                          style: formBox(),
                                        ),
                                        activeColor: Colors.amber,
                                        secondary: Container(
                                          height: 45,
                                          child: Image.asset(images[3]),
                                        ),
                                        onChanged: (val) {
                                          setSelectedRadioTile(val);
                                        },
                                        selected: false,
                                      )),
                                  Card(
                                      elevation: 5,
                                      child: RadioListTile(
                                        value: 5,
                                        groupValue: selectedRadioTile,
                                        title: Text(
                                          "Lotion",
                                          style: formBox(),
                                        ),
                                        activeColor: Colors.amber,
                                        secondary: Container(
                                          height: 45,
                                          child: Image.asset(images[4]),
                                        ),
                                        onChanged: (val) {
                                          setSelectedRadioTile(val);
                                        },
                                        selected: true,
                                      )),
                                  Card(
                                      elevation: 5,
                                      child: RadioListTile(
                                        value: 6,
                                        groupValue: selectedRadioTile,
                                        title: Text(
                                          "Syringe",
                                          style: formBox(),
                                        ),
                                        activeColor: Colors.amber,
                                        secondary: Container(
                                          height: 45,
                                          child: Image.asset(images[5]),
                                        ),
                                        onChanged: (val) {
                                          setSelectedRadioTile(val);
                                        },
                                        selected: false,
                                      )),
                                  Card(
                                      elevation: 5,
                                      child: RadioListTile(
                                        value: 7,
                                        groupValue: selectedRadioTile,
                                        title: Text(
                                          "Inhaler",
                                          style: formBox(),
                                        ),
                                        activeColor: Colors.amber,
                                        secondary: Container(
                                          height: 45,
                                          child: Image.asset(images[6]),
                                        ),
                                        onChanged: (val) {
                                          setSelectedRadioTile(val);
                                        },
                                        selected: false,
                                      )),
                                ]))
                      ]))),
          Card(
              elevation: 5,
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      "  Medicine Days",
                      style: formTitle(),
                      textAlign: TextAlign.left,
                    ),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: everythingSelected(daySelected)
                              ? iseveryday = iseveryday
                              : iseveryday = false,
                          onChanged: (bool value) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            setState(() {
                              for (int i = 0; i < daySelected.length; i++) {
                                daySelected[i] = true;
                              }
                              if (iseveryday == true && value == false) {
                                for (int i = 0; i < daySelected.length; i++) {
                                  daySelected[i] = false;
                                }
                              }
                              iseveryday = value;
                            });
                          },
                        ),
                        Text(
                          "Everyday",
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        dayFlatButton("S", 0),
                        dayFlatButton("M", 1),
                        dayFlatButton("T", 2),
                        dayFlatButton("W", 3),
                        dayFlatButton("T", 4),
                        dayFlatButton("F", 5),
                        dayFlatButton("S", 6),
                      ],
                    )
                  ],
                ),
              )),
          Card(
              elevation: 5,
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
              child: Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        "Time",
                        style: formTitle(),
                        textAlign: TextAlign.left,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                                _time.hour > 12
                                    ? (_time.minute < 10
                                        ? '${_time.hour - 12}:0${_time.minute}pm'
                                        : '${_time.hour - 12}:${_time.minute}pm')
                                    : (_time.minute < 10
                                        ? '${_time.hour}:0${_time.minute}am'
                                        : '${_time.hour}:${_time.minute}am'),
                                style: TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Montserrat')),
                          ),
                          Expanded(
                            child: Container(
                              child: RaisedButton(
                                onPressed: () => selectTime(context),
                                color: Colors.amber,
                                elevation: 3,
                                child: Text(
                                  "Change Time",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Montserrat'),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                              ),
                              height: 50,
                              margin: EdgeInsets.only(left: 5),
                            ),
                          )
                        ],
                      )
                    ],
                  ))),
          Container(
            margin: EdgeInsets.only(right: 20, bottom: 30, top: 10, left: 20),
            child: Row(
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
                          save(context);
                        });
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat'),
                      ),
                      elevation: 2,
                      color: Colors.amber,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                    height: 50,
                    padding: EdgeInsets.only(right: 20),
                  ),
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
                            side: BorderSide(color: Colors.amber, width: 3)),
                      ),
                      height: 50,
                      padding: EdgeInsets.only(right: 20)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void updateTitle() {
    med.title = titleController.text;
  }

  // Update the description of Note object
  void updateMedName() {
    med.medName = medNameController.text;
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void save(BuildContext context) async {
    List<String> selectedDays = [];
    for (int i = 0; i < 7; i++) {
      if (daySelected[i]) selectedDays.add(day[i]);
    }
    med.medIcon = images[selectedRadioTile-1];
    med.days = selectedDays.toString();
    med.isCompleted = false;
    med.isTakenOnTime = false;

    int result;
    for (int i = 0; i < selectedDays.length; i++) {
      result = await helper.insertNote(med, "${selectedDays[i]}");
      if (result != 0) {
        debugPrint("Successfully added to ${selectedDays[i]}");
      } else {
        debugPrint("Add failed to ${selectedDays[i]}");
      }
    }
    moveToLastScreen();
    pageChanger(1);
  }
}

TextStyle formTitle() {
  return TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontFamily: 'Montserrat');
}

TextStyle formBox() {
  return TextStyle(
      fontSize: 26,
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontFamily: 'Montserrat');
}
