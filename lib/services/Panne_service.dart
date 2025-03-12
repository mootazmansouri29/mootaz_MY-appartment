import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import '../models/panne.dart'; 

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
      CREATE TABLE panne (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_équipement INTEGER NOT NULL,
        description TEXT NOT NULL,
        date_signalement TEXT NOT NULL,
        statut TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertPanne(Panne panne) async {
    final db = await database;
    await db.insert('panne', panne.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Panne>> getPannes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('panne');
    return maps.map((map) => Panne.fromMap(map)).toList();
  }

  Future<void> updatePanne(Panne panne) async {
    final db = await database;
    await db.update(
      'panne',
      panne.toMap(),
      where: 'id = ?',
      whereArgs: [panne.id],
    );
  }

  Future<void> deletePanne(int id) async {
    final db = await database;
    await db.delete('panne', where: 'id = ?', whereArgs: [id]);
  }
}
