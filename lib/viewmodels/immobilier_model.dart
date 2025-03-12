import 'package:flutter/material.dart';
import '../models/immobilier.dart';
import '../services/immobilier_service.dart';

class ImmobilierViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  List<Immobilier> _immobiliers = [];

  List<Immobilier> get immobiliers => _immobiliers;

  Future<void> fetchImmobiliers() async {
    _immobiliers = await _databaseService.getImmobiliers();
    notifyListeners();
  }

  Future<void> addImmobilier(Immobilier immobilier) async {
    await _databaseService.insertImmobilier(immobilier);
    await fetchImmobiliers();
  }

  Future<void> deleteImmobilier(int id) async {
    await _databaseService.deleteImmobilier(id);
    await fetchImmobiliers();
  }

  Future<void> updateImmobilier(Immobilier immobilier) async {
    await _databaseService.updateImmobilier(immobilier);
    await fetchImmobiliers();
  }
}
