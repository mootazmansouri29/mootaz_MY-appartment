import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import '../models/equipement.dart'; 

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
      CREATE TABLE equipement (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_piece INTEGER NOT NULL,
        libelle TEXT NOT NULL,
        quantite INTEGER NOT NULL,
        numero_equipements TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertEquipement(Equipement equipement) async {
    final db = await database;
    await db.insert('equipement', equipement.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Equipement>> getEquipements() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('equipement');
    return maps.map((map) => Equipement.fromMap(map)).toList();
  }

  Future<void> updateEquipement(Equipement equipement) async {
    final db = await database;
    await db.update(
      'equipement',
      equipement.toMap(),
      where: 'id = ?',
      whereArgs: [equipement.id],
    );
  }

  Future<void> deleteEquipement(int id) async {
    final db = await database;
    await db.delete('equipement', where: 'id = ?', whereArgs: [id]);
  }
}
