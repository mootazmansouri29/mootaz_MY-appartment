import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import '../models/reclamation.dart'; 

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
      CREATE TABLE reclamation (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_client INTEGER NOT NULL,
        description TEXT NOT NULL,
        date TEXT NOT NULL,
        statut TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertReclamation(Reclamation reclamation) async {
    final db = await database;
    await db.insert('reclamation', reclamation.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Reclamation>> getReclamations() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('reclamation');
    return maps.map((map) => Reclamation.fromMap(map)).toList();
  }

  Future<void> updateReclamation(Reclamation reclamation) async {
    final db = await database;
    await db.update(
      'reclamation',
      reclamation.toMap(),
      where: 'id = ?',
      whereArgs: [reclamation.id],
    );
  }

  Future<void> deleteReclamation(int id) async {
    final db = await database;
    await db.delete('reclamation', where: 'id = ?', whereArgs: [id]);
  }
}
