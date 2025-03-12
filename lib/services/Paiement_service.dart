import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import '../models/paiement.dart'; 

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
      CREATE TABLE paiement (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_client INTEGER NOT NULL,
        montant REAL NOT NULL,
        date_paiement TEXT NOT NULL,
        mode_paiement TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertPaiement(Paiement paiement) async {
    final db = await database;
    await db.insert('paiement', paiement.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Paiement>> getPaiements() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('paiement');
    return maps.map((map) => Paiement.fromMap(map)).toList();
  }

  Future<void> updatePaiement(Paiement paiement) async {
    final db = await database;
    await db.update(
      'paiement',
      paiement.toMap(),
      where: 'id = ?',
      whereArgs: [paiement.id],
    );
  }

  Future<void> deletePaiement(int id) async {
    final db = await database;
    await db.delete('paiement', where: 'id = ?', whereArgs: [id]);
  }
}
