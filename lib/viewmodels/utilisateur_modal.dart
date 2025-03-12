import 'package:flutter/material.dart';
import '../models/utilisateur.dart';
import '../services/utlisateur_service.dart';

class UtilisateurViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  List<Utilisateur> _utilisateurs = [];

  List<Utilisateur> get utilisateurs => _utilisateurs;

  // Récupérer tous les utilisateurs depuis la base de données
  Future<void> fetchUtilisateurs() async {
    _utilisateurs = await _databaseService.getUtilisateurs();
    notifyListeners();
  }

  // Ajouter un nouvel utilisateur à la base de données
  Future<void> addUtilisateur(Utilisateur utilisateur) async {
    await _databaseService.insertUtilisateur(utilisateur);
    await fetchUtilisateurs();
  }

  // Supprimer un utilisateur de la base de données
  Future<void> deleteUtilisateur(int id) async {
    await _databaseService.deleteUtilisateur(id);
    await fetchUtilisateurs();
  }

  // Mettre à jour un utilisateur dans la base de données
  Future<void> updateUtilisateur(Utilisateur utilisateur) async {
    await _databaseService.updateUtilisateur(utilisateur);
    await fetchUtilisateurs();
  }
}
