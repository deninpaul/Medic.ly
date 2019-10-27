import 'package:flutter/material.dart';

class Note {
  int _id;
  String _title;
  String _medName;
  String _description;
  String _day;
  TimeOfDay _time;

  Note(this._title, this._day, this._time, this._medName, this._description);

  Note.withId(this._id, this._title, this._time, this._day, this._medName,
      this._description);

  int get id => _id;

  String get title => _title;

  String get medName => _medName;

  String get day => _day;

  TimeOfDay get time => _time;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set medName(String newmedName) {
    if (newmedName.length <= 255) {
      this._medName = newmedName;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  set time(TimeOfDay newtime) {
    this._time = newtime;
  }

  set day(String newDay) {
    this._day = newDay;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['medName'] = _medName;
    map['day'] = _day;
    map['time'] = _time;

    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._day = map['day'];
    this._time = map['time'];
  }
}
