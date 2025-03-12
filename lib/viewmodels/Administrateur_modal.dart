import 'package:flutter/material.dart';
import '../models/administrateur.dart';
import '../services/administrateur_service.dart';

class AdministrateurViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  List<Administrateur> _administrateurs = [];

  List<Administrateur> get administrateurs => _administrateurs;

  // Fetch all administrateurs from the database
  Future<void> fetchAdministrateurs() async {
    _administrateurs = await _databaseService.getAdministrateurs();
    notifyListeners();
  }

  // Add a new administrateur to the database
  Future<void> addAdministrateur(Administrateur administrateur) async {
    await _databaseService.insertAdministrateur(administrateur);
    await fetchAdministrateurs();
  }

  // Delete an administrateur from the database
  Future<void> deleteAdministrateur(int id) async {
    await _databaseService.deleteAdministrateur(id);
    await fetchAdministrateurs();
  }

  // Update an administrateur in the database
  Future<void> updateAdministrateur(Administrateur administrateur) async {
    await _databaseService.updateAdministrateur(administrateur);
    await fetchAdministrateurs();
  }
}
