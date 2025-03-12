import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import '../models/piece.dart'; 

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
      CREATE TABLE piece (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_maison INTEGER NOT NULL,
      )
    ''');
  }

  Future<void> insertPiece(Piece piece) async {
    final db = await database;
    await db.insert('piece', piece.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Piece>> getPieces() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('piece');
    return maps.map((map) => Piece.fromMap(map)).toList();
  }

  Future<void> updatePiece(Piece piece) async {
    final db = await database;
    await db.update(
      'piece',
      piece.toMap(),
      where: 'id = ?',
      whereArgs: [piece.id],
    );
  }

  Future<void> deletePiece(int id) async {
    final db = await database;
    await db.delete('piece', where: 'id = ?', whereArgs: [id]);
  }
}
