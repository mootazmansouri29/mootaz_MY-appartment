class Intervention {
  int? idInter;           
  int idReclam;          
  int idUtil;            
  String dateIntervention; 
  String resultat;        
  String commentaire;     

  Intervention({
    this.idInter,
    required this.idReclam,
    required this.idUtil,
    required this.dateIntervention,
    required this.resultat,
    required this.commentaire,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_inter': idInter,
      'id_reclam': idReclam,
      'id_util': idUtil,
      'dateIntervention': dateIntervention,
      'resultat': resultat,
      'commentaire': commentaire,
    };
  }

  factory Intervention.fromMap(Map<String, dynamic> map) {
    return Intervention(
      idInter: map['id_inter'],
      idReclam: map['id_reclam'],
      idUtil: map['id_util'],
      dateIntervention: map['dateIntervention'],
      resultat: map['resultat'],
      commentaire: map['commentaire'],
    );
  }
}
