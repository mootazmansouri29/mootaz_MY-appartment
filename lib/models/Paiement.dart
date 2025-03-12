class Paiement {
  int? id;
  int idutilisateur;
  double montant;
  String datePaiement;
  String modePaiement;

  Paiement({
    this.id,
    required this.idutilisateur,
    required this.montant,
    required this.datePaiement,
    required this.modePaiement,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_utilisateur': idutilisateur,
      'montant': montant,
      'date_paiement': datePaiement,
      'mode_paiement': modePaiement,
    };
  }

  factory Paiement.fromMap(Map<String, dynamic> map) {
    return Paiement(
      id: map['id'],
      idutilisateur: map['id_utilisateur'],
      montant: map['montant'].toDouble(),
      datePaiement: map['date_paiement'],
      modePaiement: map['mode_paiement'],
    );
  }
}
