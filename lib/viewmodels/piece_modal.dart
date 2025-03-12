import 'package:flutter/material.dart';
import '../models/piece.dart';
import '../services/piece_service.dart';

class PieceViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  List<Piece> _pieces = [];

  List<Piece> get pieces => _pieces;

  Future<void> fetchPieces() async {
    _pieces = await _databaseService.getPieces();
    notifyListeners();
  }

  Future<void> addPiece(Piece piece) async {
    await _databaseService.insertPiece(piece);
    await fetchPieces();
  }

  Future<void> deletePiece(int id) async {
    await _databaseService.deletePiece(id);
    await fetchPieces();
  }

  Future<void> updatePiece(Piece piece) async {
    await _databaseService.updatePiece(piece);
    await fetchPieces();
  }
}
