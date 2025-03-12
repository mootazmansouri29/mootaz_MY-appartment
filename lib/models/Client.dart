class Client {
  int? id;
  String nom;
  String prenom;
  String email;
  String telephone;

  Client({
    this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.telephone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'telephone': telephone,
    };
  }

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map['id'],
      nom: map['nom'],
      prenom: map['prenom'],
      email: map['email'],
      telephone: map['telephone'],
    );
  }
}
