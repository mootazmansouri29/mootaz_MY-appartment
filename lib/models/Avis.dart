class Avis {
  int? id;
  int idutilisateur;
  double note;
  String commentaire;
  String date;

  Avis({
    this.id,
    required this.idutilisateur,
    required this.note,
    required this.commentaire,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_utilisateur': idutilisateur,
      'note': note,
      'commentaire': commentaire,
      'date': date,
    };
  }

  factory Avis.fromMap(Map<String, dynamic> map) {
    return Avis(
      id: map['id'],
      idutilisateur: map['id_utilisateur'],
      note: map['note'].toDouble(),
      commentaire: map['commentaire'],
      date: map['date'],
    );
  }
}
