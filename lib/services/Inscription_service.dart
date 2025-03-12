import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import '../models/inscription.dart'; 

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
      CREATE TABLE inscription (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_client INTEGER NOT NULL,
        date_inscription TEXT NOT NULL,
        statut TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertInscription(Inscription inscription) async {
    final db = await database;
    await db.insert('inscription', inscription.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Inscription>> getInscriptions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('inscription');
    return maps.map((map) => Inscription.fromMap(map)).toList();
  }

  Future<void> updateInscription(Inscription inscription) async {
    final db = await database;
    await db.update(
      'inscription',
      inscription.toMap(),
      where: 'id = ?',
      whereArgs: [inscription.id],
    );
  }

  Future<void> deleteInscription(int id) async {
    final db = await database;
    await db.delete('inscription', where: 'id = ?', whereArgs: [id]);
  }
}
