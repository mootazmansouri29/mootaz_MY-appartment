import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import '../models/immobilier.dart'; 

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
      CREATE TABLE immobilier (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL,
        adresse TEXT NOT NULL,
        type TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertImmobilier(Immobilier immobilier) async {
    final db = await database;
    await db.insert('immobilier', immobilier.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Immobilier>> getImmobiliers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('immobilier');
    return maps.map((map) => Immobilier.fromMap(map)).toList();
  }

  Future<void> updateImmobilier(Immobilier immobilier) async {
    final db = await database;
    await db.update(
      'immobilier',
      immobilier.toMap(),
      where: 'id = ?',
      whereArgs: [immobilier.id_imm],
    );
  }

  Future<void> deleteImmobilier(int id) async {
    final db = await database;
    await db.delete('immobilier', where: 'id = ?', whereArgs: [id]);
  }
}
