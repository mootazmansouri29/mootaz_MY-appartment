import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import '../models/utilisateur.dart';

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
      CREATE TABLE utilisateur (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL,
        prenom TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        mot_de_passe TEXT NOT NULL,
        role TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertUtilisateur(Utilisateur utilisateur) async {
    final db = await database;
    await db.insert('utilisateur', utilisateur.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Utilisateur>> getUtilisateurs() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('utilisateur');
    return maps.map((map) => Utilisateur.fromMap(map)).toList();
  }

  Future<void> updateUtilisateur(Utilisateur utilisateur) async {
    final db = await database;
    await db.update(
      'utilisateur',
      utilisateur.toMap(),
      where: 'id = ?',
      whereArgs: [utilisateur.id],
    );
  }

  Future<void> deleteUtilisateur(int id) async {
    final db = await database;
    await db.delete('utilisateur', where: 'id = ?', whereArgs: [id]);
  }
}
