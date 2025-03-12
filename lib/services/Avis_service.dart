import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import '../models/avis.dart'; 

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
      CREATE TABLE avis (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_client INTEGER NOT NULL,
        note INTEGER NOT NULL,
        commentaire TEXT,
        date TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertAvis(Avis avis) async {
    final db = await database;
    await db.insert('avis', avis.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Avis>> getAvis() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('avis');
    return maps.map((map) => Avis.fromMap(map)).toList();
  }

  Future<void> updateAvis(Avis avis) async {
    final db = await database;
    await db.update(
      'avis',
      avis.toMap(),
      where: 'id = ?',
      whereArgs: [avis.id],
    );
  }

  Future<void> deleteAvis(int id) async {
    final db = await database;
    await db.delete('avis', where: 'id = ?', whereArgs: [id]);
  }
}
