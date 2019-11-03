//import 'package:flutter/material.dart';
//import 'package:sqflite/sqflite.dart';
//import 'package:path/path.dart';
//import 'package:collection/collection.dart';

class Medicine {
  int id;
  String title;
  String medName;
  String days;
  String time;
  bool isCompleted;
  bool isTakenOnTime;
  String medIcon;

  Medicine({this.id, this.title, this.days, this.time, this.medName, this.isCompleted, this.isTakenOnTime, this.medIcon});

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'medName': medName,
      'days': days,
      'time': time,
      'isCompleted': isCompleted,
      'isTakenOnTime': isTakenOnTime,
      'medIcon': medIcon
    };
  }

  // Extract a Note object from a Map object
  Medicine.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.medName = map['medName'];
    this.days = map['days'];
    this.time = map['time'];
    this.isTakenOnTime = map['isTakenOnTime']==1?true:false;
    this.isCompleted = map['isCompleted']==1?true:false;
    this.medIcon = map['medIcon'];
  }
}
