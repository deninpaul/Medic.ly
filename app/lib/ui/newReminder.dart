import 'package:flutter/material.dart';

class NewMed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New Medicine Page',
      theme: ThemeData(primarySwatch: Colors.amber, fontFamily: 'Montserrat'),
      home: Scaffold(
          appBar: AppBar(
            title: Text(
              "New Medicine",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context, false),
              color: Colors.black,
            ),
            elevation: 10,
            backgroundColor: Colors.white,
          ),
          body: NewMedPage()),
    );
  }
}

class NewMedPage extends StatefulWidget {
  NewMedPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  NewMedPageState createState() => NewMedPageState();
}

class NewMedPageState extends State<NewMedPage> {
  List<bool> daySelected = [false, false, false, false, false, false, false];
  TimeOfDay _time = new TimeOfDay.now();
  bool iseveryday = true;

  void _daySelector(int i) {
    setState(() {
      daySelected[i] = !daySelected[i];
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
      });
    }
  }

  Expanded dayFlatButton(String dayname, int i) {
    return Expanded(
        child: Container(
      child: FlatButton(
        onPressed: () => _daySelector(i),
        color: daySelected[i] ? Colors.amber : Colors.amber[100],
        child: Text(dayname),
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
    return ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Container(
          height: 30,
        ),
        textFieldCard("Medicine Name"),
        textFieldCard("Treatment For"),
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
                                  ? '${_time.hour - 12}:${_time.minute}pm'
                                  : '${_time.hour}:${_time.minute}am',
                              style: TextStyle(
                                  fontSize: 36, fontWeight: FontWeight.w700)),
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
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            height: 50,
                            margin: EdgeInsets.only(left: 5),
                          ),
                        )
                      ],
                    )
                  ],
                )))
      ],
    );
  }
}

class DaySelector {}

TextStyle formTitle() {
  return TextStyle(
      fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600);
}

TextStyle formBox() {
  return TextStyle(
      fontSize: 26, color: Colors.black, fontWeight: FontWeight.w500);
}

Card textFieldCard(String fieldName) {
  return Card(
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
              fieldName,
              style: formTitle(),
              textAlign: TextAlign.left,
            ),
            TextField(
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 2)),
                  contentPadding: EdgeInsets.all(10)),
              style: formBox(),
            ),
          ],
        ),
      ));
}
