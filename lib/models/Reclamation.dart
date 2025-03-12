class Reclamation {
  int? idReclam;          
  int idUtil;             
  int idEquipement;       
  String description;
  String dateCreation;    
  String statut;

  Reclamation({
    this.idReclam,
    required this.idUtil,
    required this.idEquipement,
    required this.description,
    required this.dateCreation,
    required this.statut,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_reclam': idReclam,
      'id_util': idUtil,
      'id_equipement': idEquipement,
      'description': description,
      'dateCreation': dateCreation,
      'statut': statut,
    };
  }

  factory Reclamation.fromMap(Map<String, dynamic> map) {
    return Reclamation(
      idReclam: map['id_reclam'],
      idUtil: map['id_util'],
      idEquipement: map['id_equipement'],
      description: map['description'],
      dateCreation: map['dateCreation'],
      statut: map['statut'],
    );
  }
}
