class Panne {
  int? id;
  int idEquipement;
  String typePanne;
  String gravite;
  String dateSignalement;
  String descriptionPanne;

  Panne({
    this.id,
    required this.idEquipement,
    required this.typePanne,
    required this.gravite,
    required this.dateSignalement,
    required this.descriptionPanne,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_equipement': idEquipement,
      'typepanne': typePanne,
      'gravite': gravite,
      'date_signalement': dateSignalement,
      'descriptionPanne': descriptionPanne,
    };
  }

  factory Panne.fromMap(Map<String, dynamic> map) {
    return Panne(
      id: map['id'],
      idEquipement: map['id_equipement'],
      typePanne: map['typepanne'],
      gravite: map['gravite'],
      dateSignalement: map['date_signalement'],
      descriptionPanne: map['descriptionPanne'],
    );
  }
}