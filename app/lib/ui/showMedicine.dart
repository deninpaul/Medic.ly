import 'package:flutter/material.dart';
import 'package:app/utils/database_helper.dart';
import 'package:app/models/medicine.dart';
import 'package:sqflite/sqflite.dart';
import 'package:app/utils/global.dart';

class Medicines extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicines',
      theme:ThemeData(primarySwatch: Colors.amber, fontFamily: 'Montserrat'),
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              child: Text(
                "Coming Soon :)",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,),
              ),
              alignment: AlignmentDirectional.center,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
