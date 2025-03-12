import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import '../models/rapport.dart'; 

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();

  factory DatabaseService() => _instance;

  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'immobilier.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE rapport (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_technicien INTEGER NOT NULL,
        contenu TEXT NOT NULL,
        date_rapport TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertRapport(Rapport rapport) async {
    final db = await database;
    await db.insert('rapport', rapport.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Rapport>> getRapports() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('rapport');
    return maps.map((map) => Rapport.fromMap(map)).toList();
  }

  Future<void> updateRapport(Rapport rapport) async {
    final db = await database;
    await db.update(
      'rapport',
      rapport.toMap(),
      where: 'id = ?',
      whereArgs: [rapport.id],
    );
  }

  Future<void> deleteRapport(int id) async {
    final db = await database;
    await db.delete('rapport', where: 'id = ?', whereArgs: [id]);
  }
}
