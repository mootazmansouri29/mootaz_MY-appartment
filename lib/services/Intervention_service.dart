import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import '../models/intervention.dart'; 

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
      CREATE TABLE intervention (
        id_inter INTEGER PRIMARY KEY AUTOINCREMENT,
        id_reclam INTEGER NOT NULL,
        id_util INTEGER NOT NULL,
        dateIntervention TEXT NOT NULL,
        resultat TEXT NOT NULL,
        commentaire TEXT
      )
    ''');
  }

  Future<void> insertIntervention(Intervention intervention) async {
    final db = await database;
    await db.insert('intervention', intervention.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Intervention>> getInterventions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('intervention');
    return maps.map((map) => Intervention.fromMap(map)).toList();
  }

  Future<void> updateIntervention(Intervention intervention) async {
    final db = await database;
    await db.update(
      'intervention',
      intervention.toMap(),
      where: 'id_inter = ?',
      whereArgs: [intervention.idInter],
    );
  }

  Future<void> deleteIntervention(int id) async {
    final db = await database;
    await db.delete('intervention', where: 'id_inter = ?', whereArgs: [id]);
  }
}
