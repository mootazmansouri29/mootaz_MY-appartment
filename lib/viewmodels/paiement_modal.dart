import 'package:flutter/material.dart';
import '../models/paiement.dart';
import '../services/paiement_service.dart';

class PaiementViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  List<Paiement> _paiements = [];

  List<Paiement> get paiements => _paiements;

  // Fetch all paiements from the database
  Future<void> fetchPaiements() async {
    _paiements = await _databaseService.getPaiements();
    notifyListeners();
  }

  // Add a new paiement to the database
  Future<void> addPaiement(Paiement paiement) async {
    await _databaseService.insertPaiement(paiement);
    await fetchPaiements();
  }

  // Delete a paiement from the database
  Future<void> deletePaiement(int id) async {
    await _databaseService.deletePaiement(id);
    await fetchPaiements();
  }

  // Update a paiement in the database
  Future<void> updatePaiement(Paiement paiement) async {
    await _databaseService.updatePaiement(paiement);
    await fetchPaiements();
  }
}
