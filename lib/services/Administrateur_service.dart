import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import '../models/administrateur.dart'; 

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
      CREATE TABLE administrateur (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL,
        email TEXT NOT NULL,
        role TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertAdministrateur(Administrateur administrateur) async {
    final db = await database;
    await db.insert('administrateur', administrateur.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Administrateur>> getAdministrateurs() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('administrateur');
    return maps.map((map) => Administrateur.fromMap(map)).toList();
  }

  Future<void> updateAdministrateur(Administrateur administrateur) async {
    final db = await database;
    await db.update(
      'administrateur',
      administrateur.toMap(),
      where: 'id = ?',
      whereArgs: [administrateur.id],
    );
  }

  Future<void> deleteAdministrateur(int id) async {
    final db = await database;
    await db.delete('administrateur', where: 'id = ?', whereArgs: [id]);
  }
}
