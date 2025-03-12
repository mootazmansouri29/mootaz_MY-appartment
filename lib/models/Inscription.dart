class Inscription {
  int? id;
  int idClient;
  String dateInscription;
  String statut;

  Inscription({
    this.id,
    required this.idClient,
    required this.dateInscription,
    required this.statut,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_client': idClient,
      'date_inscription': dateInscription,
      'statut': statut,
    };
  }

  factory Inscription.fromMap(Map<String, dynamic> map) {
    return Inscription(
      id: map['id'],
      idClient: map['id_client'],
      dateInscription: map['date_inscription'],
      statut: map['statut'],
    );
  }
}
