import 'package:flutter/material.dart';
import '../models/technicien.dart';
import '../services/technicien_service.dart';

class TechnicienViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  List<Technicien> _techniciens = [];

  List<Technicien> get techniciens => _techniciens;

  // Fetch all techniciens from the database
  Future<void> fetchTechniciens() async {
    _techniciens = await _databaseService.getTechniciens();
    notifyListeners();
  }

  // Add a new technicien to the database
  Future<void> addTechnicien(Technicien technicien) async {
    await _databaseService.insertTechnicien(technicien);
    await fetchTechniciens();
  }

  // Delete a technicien from the database
  Future<void> deleteTechnicien(int id) async {
    await _databaseService.deleteTechnicien(id);
    await fetchTechniciens();
  }

  // Update a technicien in the database
  Future<void> updateTechnicien(Technicien technicien) async {
    await _databaseService.updateTechnicien(technicien);
    await fetchTechniciens();
  }
}
