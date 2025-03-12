import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import '../models/technicien.dart'; 

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
      CREATE TABLE technicien (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL,
        specialite TEXT NOT NULL,
        telephone TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertTechnicien(Technicien technicien) async {
    final db = await database;
    await db.insert('technicien', technicien.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Technicien>> getTechniciens() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('technicien');
    return maps.map((map) => Technicien.fromMap(map)).toList();
  }

  Future<void> updateTechnicien(Technicien technicien) async {
    final db = await database;
    await db.update(
      'technicien',
      technicien.toMap(),
      where: 'id = ?',
      whereArgs: [technicien.id],
    );
  }

  Future<void> deleteTechnicien(int id) async {
    final db = await database;
    await db.delete('technicien', where: 'id = ?', whereArgs: [id]);
  }
}
