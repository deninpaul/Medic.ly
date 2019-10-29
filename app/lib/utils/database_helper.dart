import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:app/models/medicine.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database db;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (db == null) {
      db = await initializeDatabase();
    }
    return db;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    final database = openDatabase(
      join(await getDatabasesPath(), 'medicine_database.db'),
      onCreate: (db, version) => _oncreate,
      version: 1,
    );
    return database;
  }

  void _oncreate(Database db, int newVersion) async {
    // List<String> day = [
    //   'sunday',
    //   'monday',
    //   'tuesday',
    //   'wednesday',
    //   'thursday',
    //   'friday',
    //   'saturday'
    // ];
    await db.execute(
        'CREATE TABLE medicines(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, medName TEXT, days TEXT, time TEXT)');
  }

  Future<int> insertMed(Medicine med) async {
    final Database db = await database;
    var result = await db.insert(
      'medicines',
      med.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  Future<List<Medicine>> medicines() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('medicines');
    return List.generate(maps.length, (i) {
      return Medicine(
        id: maps[i]['id'],
        title: maps[i]['title'],
        medName: maps[i]['medName'],
        days: maps[i]['days'],
        time: maps[i]['time'],
      );
    });
  }

  Future<int> updateMed(Medicine med) async {
    final db = await database;
    var result = await db.update(
      'medicines',
      med.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [med.id],
    );
    return result;
  }

  Future<int> deleteMed(int id) async {
    final db = await database;
    var result = await db.delete(
      'medicines',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
    return result;
  }
}
