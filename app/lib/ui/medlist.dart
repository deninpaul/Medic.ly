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
  
  DatabaseHelper databaseHelper =DatabaseHelper();
  List<Medicine> sunList, monList, tueList, wedList, thuList, friList, satList;
  
  @override
  Widget build(BuildContext context) {
    if(sunList == null){
      sunList= List<Medicine>();
      updateListView("sunday", sunList);
    }

    if(monList == null){
      monList= List<Medicine>();
      updateListView("monday", monList);
    }

    if(tueList == null){
      tueList= List<Medicine>();
      updateListView("tuesday", tueList);
    }

    if(wedList == null){
      wedList= List<Medicine>();
      updateListView("wednesday", wedList);
    }

    if(thuList == null){
      thuList= List<Medicine>();
      updateListView("thursday", thuList);
    }

    if(friList == null){
      friList= List<Medicine>();
      updateListView("friday", friList);
    }

    if(satList == null){
      satList= List<Medicine>();
      updateListView("saturday", satList);
    }
    
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
          margin: EdgeInsets.only(left:25, bottom: 25, top: 25),
          height: 150,
          child: Card(
            child: getMedListView(daylist),
            elevation: 3,
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
    itemBuilder: (context, int position){
      return Card(
        color: Colors.white,
        elevation: 5,
        child: Container(
          width: 150,
          height: 150,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                height: 80,
                width: 80,
                child: Icon(Icons.remove_circle),
              ),
              Text(daylist[position].title, style:TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black) ),
              Text(daylist[position].title, style:TextStyle(fontSize: 14, fontWeight: FontWeight.w800))
            ],
          )
        ),
        );
    },
  );
}

void updateListView(String day, List<Medicine> daylist) {

		final Future<Database> dbFuture = databaseHelper.initializeDatabase();
		dbFuture.then((database) {

			Future<List<Medicine>> noteListFuture = databaseHelper.getNoteList(day);
			noteListFuture.then((noteList) {
				setState(() {
				  daylist = noteList;
          debugPrint("${daylist.length}");
				});
			});
		});
  }

}