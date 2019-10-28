import 'package:flutter/material.dart';

class Note {
  int _id;
  String _title;
  String _medName;
  String _description;
  List<String> _days;
  TimeOfDay _time;

  Note(this._title, this._days, this._time, this._medName, this._description);

  Note.withId(this._id, this._title, this._time, this._days, this._medName,
      this._description);

  int get id => _id;

  String get title => _title;

  String get medName => _medName;

  List<String> get days => _days;

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

  set day(List<String> newDays) {
    this._days = newDays;
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
    map['days'] = _days;
    map['time'] = _time;

    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._days = map['days'];
    this._time = map['time'];
  }
}
