class Immobilier {
  int? id_imm;
  String nom;
  String adresse;
  String type;

  Immobilier({this.id_imm, required this.nom, required this.adresse, required this.type});

  Map<String, dynamic> toMap() {
    return {
      'id_imm': id_imm,
      'nom': nom,
      'adresse': adresse,
      'type': type,
    };
  }

  factory Immobilier.fromMap(Map<String, dynamic> map) {
    return Immobilier(
      id_imm: map['id_imm'],
      nom: map['nom'],
      adresse: map['adresse'],
      type: map['type'],
    );
  }
}
