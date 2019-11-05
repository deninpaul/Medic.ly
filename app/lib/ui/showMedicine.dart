import 'package:app/ui/editMed.dart';
import 'package:flutter/material.dart';
import 'package:app/utils/database_helper.dart';
import 'package:app/models/medicine.dart';
import 'package:sqflite/sqflite.dart';
import 'package:app/utils/global.dart';

class Medicines extends StatelessWidget {
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
        MedicinesState(),
      ],
    );
  }
}

class MedicinesState extends StatefulWidget {
  MedicinesState({Key key, this.title}) : super(key: key);
  final String title;

  @override
  ListMedicines createState() => ListMedicines();
}

class ListMedicines extends State<MedicinesState> {
  List<Medicine> fullList;
  int count = 0;
  DatabaseHelper databaseHelper = DatabaseHelper();

  List<String> medicinelist = List<String>();
  List<String> titlelist = List<String>();
  List<String> medIconlist = List<String>();

  @override
  Widget build(BuildContext context) {
    updateListView();
    updateMedListView();
    return Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(top: 20),
            child: ListView.builder(
              itemCount: medicinelist.length,
              itemBuilder: (context, int position) {
                return Container(
                    padding: EdgeInsets.all(15),
                    height: 160,
                    child: RaisedButton(
                      color: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditMedPage(
                                      medname: medicinelist[position],
                                      fullList: fullList,
                                      medicon: medIconlist[position],
                                      medtitle: titlelist[position],
                                    )));
                      },
                      child: Container(
                        padding: EdgeInsets.only(bottom: 5, top: 5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    child: Image.asset(medIconlist[position]),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          new BoxShadow(
                                              color: Colors.black38,
                                              blurRadius: 5,
                                              offset: Offset(0, 2))
                                        ]),
                                  ),
                                ),
                                flex: 1,
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.fromLTRB(15, 20, 10, 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(medicinelist[position],
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w700)),
                                        flex: 2,
                                      ),
                                      Expanded(
                                        child: Text(titlelist[position],
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black)),
                                        flex: 2,
                                      ),
                                    ],
                                  ),
                                ),
                                flex: 2,
                              )
                            ]),
                      ),
                    ));
              },
            ))
      ],
    );
  }

  void updateListView() {
    if (fullList == null) {
      fullList = List<Medicine>();
      final Future<Database> dbFuture = databaseHelper.initializeDatabase();
      dbFuture.then((database) {
        Future<List<Medicine>> noteListFuture =
            databaseHelper.getAllMedicineList();
        noteListFuture.then((noteList) {
          setState(() {
            this.fullList = noteList;
            count = this.fullList.length;
          });
        });
      });
    }
  }

  void updateMedListView() {
    for (int i = 0; i < count; i++) {
      if (!medicinelist.contains(fullList[i].medName)) {
        medicinelist.add(fullList[i].medName);
        titlelist.add(fullList[i].title);
        medIconlist.add(fullList[i].medIcon);
      }
    }
  }
}
