import 'package:flutter/material.dart';
import 'package:projetville/models/immobilier.dart';
import 'package:projetville/services/immobilier_service.dart';

class AddImmobilier extends StatefulWidget {
  @override
  _AddImmobilierState createState() => _AddImmobilierState();
}

class _AddImmobilierState extends State<AddImmobilier> {
  final DatabaseService _databaseService = DatabaseService();
  final _formKey = GlobalKey<FormState>();

  final _nomController = TextEditingController();
  final _adresseController = TextEditingController();
  final _typeController = TextEditingController();

  double _progress = 0.0;
  Color _progressColor = Colors.red;

  @override
  void dispose() {
    _nomController.dispose();
    _adresseController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  void _updateProgress() {
    // Update progress when any field is changed
    int validFields = 0;

    if (_nomController.text.trim().isNotEmpty) validFields++;
    if (_adresseController.text.trim().isNotEmpty) validFields++;
    if (_typeController.text.trim().isNotEmpty) validFields++;

    setState(() {
      _progress = validFields / 3;

      // Adjust the progress bar color based on the progress
      if (_progress == 1.0) {
        _progressColor = Colors.green;
      } else if (_progress >= 0.5) {
        _progressColor = Colors.orange;
      } else {
        _progressColor = Colors.red;
      }
    });
  }

  void _saveImmobilier() async {
    if (_formKey.currentState!.validate()) {
      final immobilier = Immobilier(
        nom: _nomController.text.trim(),
        adresse: _adresseController.text.trim(),
        type: _typeController.text.trim(),
      );

      await _databaseService.insertImmobilier(immobilier);
      Navigator.pop(context); // Close the page after saving
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text('Ajouter un Immobilier', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 6.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: _progress,
              minHeight: 8,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(_progressColor),
            ),
            SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(_nomController, 'Nom', Icons.home, (value) {
                    if (value == null || value.isEmpty) return 'Veuillez entrer un nom';
                    return null;
                  }),
                  SizedBox(height: 16),
                  _buildTextField(_adresseController, 'Adresse', Icons.location_on, (value) {
                    if (value == null || value.isEmpty) return 'Veuillez entrer une adresse';
                    return null;
                  }),
                  SizedBox(height: 16),
                  _buildTextField(_typeController, 'Type', Icons.category, (value) {
                    if (value == null || value.isEmpty) return 'Veuillez entrer un type';
                    return null;
                  }),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _saveImmobilier,
                    child: Text('Enregistrer'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, String? Function(String?)? validator) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.blue),
        border: OutlineInputBorder(),
        prefixIcon: Icon(icon, color: Colors.blue),
      ),
      validator: validator,
      onChanged: (value) {
        _updateProgress(); // Update progress when input changes
      },
    );
  }
}
