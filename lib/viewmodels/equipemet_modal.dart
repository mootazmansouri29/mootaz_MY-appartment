import 'package:flutter/material.dart';
import '../models/equipement.dart';
import '../services/equipement_service.dart';

class EquipementViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  List<Equipement> _equipements = [];

  List<Equipement> get equipements => _equipements;

  // Fetch all equipements from the database
  Future<void> fetchEquipements() async {
    _equipements = await _databaseService.getEquipements();
    notifyListeners();
  }

  // Add a new equipement to the database
  Future<void> addEquipement(Equipement equipement) async {
    await _databaseService.insertEquipement(equipement);
    await fetchEquipements();
  }

  // Delete an equipement from the database
  Future<void> deleteEquipement(int id) async {
    await _databaseService.deleteEquipement(id);
    await fetchEquipements();
  }

  // Update an equipement in the database
  Future<void> updateEquipement(Equipement equipement) async {
    await _databaseService.updateEquipement(equipement);
    await fetchEquipements();
  }
}
