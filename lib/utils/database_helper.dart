import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../features/attendance/data/models/location_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'locations.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE locations(
        id TEXT PRIMARY KEY,
        name TEXT,
        latitude REAL,
        longitude REAL
      )
    ''');
  }

  Future<void> insertLocation(LocationModel location) async {
    final db = await database;
    await db.insert('locations', location.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<LocationModel>> getLocations() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('locations');
    return List.generate(maps.length, (i) {
      return LocationModel.fromMap(maps[i]);
    });
  }
}
