import 'package:flutter/material.dart';
import '../models/client.dart';
import '../services/client_service.dart';

class ClientViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  List<Client> _clients = [];

  List<Client> get clients => _clients;

  // Fetch all clients from the database
  Future<void> fetchClients() async {
    _clients = await _databaseService.getClients();
    notifyListeners();
  }

  // Add a new client to the database
  Future<void> addClient(Client client) async {
    await _databaseService.insertClient(client);
    await fetchClients();
  }

  // Delete a client from the database
  Future<void> deleteClient(int id) async {
    await _databaseService.deleteClient(id);
    await fetchClients();
  }

  // Update a client in the database
  Future<void> updateClient(Client client) async {
    await _databaseService.updateClient(client);
    await fetchClients();
  }
}
