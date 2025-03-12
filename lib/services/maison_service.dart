import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import '../models/maison.dart';

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
    final path = join(await getDatabasesPath(), 'maison.db'); 
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE maison (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_immobilier INTEGER NOT NULL,
        numero TEXT NOT NULL,
        nombre_de_piece INTEGER NOT NULL
      )
    ''');
  }

  Future<void> insertMaison(Maison maison) async {
    final db = await database;
    await db.insert('maison', maison.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Maison>> getMaisons() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('maison');
    return maps.map((map) => Maison.fromMap(map)).toList();
  }

  Future<void> updateMaison(Maison maison) async {
    final db = await database;
    await db.update(
      'maison',
      maison.toMap(),
      where: 'id = ?',
      whereArgs: [maison.id],
    );
  }

  Future<void> deleteMaison(int id) async {
    final db = await database;
    await db.delete('maison', where: 'id = ?', whereArgs: [id]);
  }
}
