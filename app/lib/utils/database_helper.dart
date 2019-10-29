import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:app/models/medicine.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'medicines.db';

    // Open/create the database at a given path
    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    List<String> day = [
      'sunday',
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday'
    ];

    for (int i = 0; i < 7; i++) {
      await db.execute(
          'CREATE TABLE ${day[i]}(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, medName TEXT, days TEXT, time TEXT)');
    }
  }

  Future<List<Map<String, dynamic>>> getNoteMapList(String day) async {
    Database db = await this.database;

    var result = await db.query('$day');
    return result;
  }

  Future<int> insertNote(Medicine med, String day) async {
    Database db = await this.database;
    var result = await db.insert('$day', med.toMap());
    return result;
  }

  Future<int> updateNote(Medicine med, String day) async {
    var db = await this.database;
    var result = await db
        .update('$day', med.toMap(), where: 'id = ?', whereArgs: [med.id]);
    return result;
  }

  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM medicines WHERE id = $id');
    return result;
  }
}
