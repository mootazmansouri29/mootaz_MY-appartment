class Equipement {
  int? id;
  int idPiece;
  String libelle;
  int quantite;
  String numeroEquipements;

  Equipement({
    this.id,
    required this.idPiece,
    required this.libelle,
    required this.quantite,
    required this.numeroEquipements,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_piece': idPiece,
      'libelle': libelle,
      'quantite': quantite,
      'numero_equipements': numeroEquipements,
    };
  }

  factory Equipement.fromMap(Map<String, dynamic> map) {
    return Equipement(
      id: map['id'],
      idPiece: map['id_piece'],
      libelle: map['libelle'],
      quantite: map['quantite'],
      numeroEquipements: map['numero_equipements'],
    );
  }
}
