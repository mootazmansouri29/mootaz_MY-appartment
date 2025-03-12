import 'package:flutter/material.dart';
import '../models/reclamation.dart'; 
import '../services/reclamation_service.dart';  

class ReclamationViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  List<Reclamation> _reclamations = [];

  List<Reclamation> get reclamations => _reclamations;

  // Fetch all reclamations from the database
  Future<void> fetchReclamations() async {
    _reclamations = await _databaseService.getReclamations();
    notifyListeners();
  }

  // Add a new reclamation to the database
  Future<void> addReclamation(Reclamation reclamation) async {
    await _databaseService.insertReclamation(reclamation);
    await fetchReclamations();
  }

  // Delete a reclamation from the database
  Future<void> deleteReclamation(int id) async {
    await _databaseService.deleteReclamation(id);
    await fetchReclamations();
  }

  // Update a reclamation in the database
  Future<void> updateReclamation(Reclamation reclamation) async {
    await _databaseService.updateReclamation(reclamation);
    await fetchReclamations();
  }
}
