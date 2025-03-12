class Technicien {
  int? id;
  String nom;
  String specialite;
  String telephone;

  Technicien({
    this.id,
    required this.nom,
    required this.specialite,
    required this.telephone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'specialite': specialite,
      'telephone': telephone,
    };
  }

  factory Technicien.fromMap(Map<String, dynamic> map) {
    return Technicien(
      id: map['id'],
      nom: map['nom'],
      specialite: map['specialite'],
      telephone: map['telephone'],
    );
  }
}
