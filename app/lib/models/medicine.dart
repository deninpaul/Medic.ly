
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:collection/collection.dart';

class Medicine {
  int id;
  String title;
  String medName;
  String days;
  String time;

  Medicine({this.id, this.title, this.days, this.time, this.medName});

  // Convert a Note object into a Map object
  Map<String,dynamic> toMap(){
    return{
      'id': id,
      'title': title,
      'medName': medName,
      'days': days,
      'time': time,
    };
  }

  // Extract a Note object from a Map object
  Medicine.fromJsonMap(Map<String, dynamic> map)
      : this.id = map['id'],
        this.title = map['title'],
        this.medName = map['medName'],
        this.days = map['days'],
        this.time = map['time'];
}
