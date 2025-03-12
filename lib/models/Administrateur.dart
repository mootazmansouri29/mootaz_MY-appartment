class Administrateur {
  int? id;
  String nom;
  String email;
  String role;

  Administrateur({
    this.id,
    required this.nom,
    required this.email,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'email': email,
      'role': role,
    };
  }

  factory Administrateur.fromMap(Map<String, dynamic> map) {
    return Administrateur(
      id: map['id'],
      nom: map['nom'],
      email: map['email'],
      role: map['role'],
    );
  }
}
