import 'package:flutter/material.dart';
import '../models/inscription.dart';
import '../services/inscription_service.dart';

class InscriptionViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  List<Inscription> _inscriptions = [];

  List<Inscription> get inscriptions => _inscriptions;

  // Fetch all inscriptions from the database
  Future<void> fetchInscriptions() async {
    _inscriptions = await _databaseService.getInscriptions();
    notifyListeners();
  }

  // Add a new inscription to the database
  Future<void> addInscription(Inscription inscription) async {
    await _databaseService.insertInscription(inscription);
    await fetchInscriptions();
  }

  // Delete an inscription from the database
  Future<void> deleteInscription(int id) async {
    await _databaseService.deleteInscription(id);
    await fetchInscriptions();
  }

  // Update an inscription in the database
  Future<void> updateInscription(Inscription inscription) async {
    await _databaseService.updateInscription(inscription);
    await fetchInscriptions();
  }
}
