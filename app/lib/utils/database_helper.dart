import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:app/models/medicine.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:path/path.dart';

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
          'CREATE TABLE ${day[i]}(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, medName TEXT, days TEXT, time TEXT, isCompleted INT, isTakenOnTime INT, medIcon TEXT)');
    }
  }

  Future<List<Map<String, dynamic>>> getNoteMapList(String day) async {
    Database db = await this.database;

    var result = await db.query('$day', orderBy: 'time ASC');
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

  Future<int> getCount(String day) async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $day');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<Medicine>> getNoteList(String day) async {
    var medicineMapList =
        await getNoteMapList(day); // Get 'Map List' from database
    int count =
        medicineMapList.length; // Count the number of map entries in db table

    List<Medicine> medicineList = List<Medicine>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      medicineList.add(Medicine.fromMapObject(medicineMapList[i]));
    }

    return medicineList;
  }
}
