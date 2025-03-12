class Piece {
  int? id_piece;
  int idMaison;
final String nom_piece;

  Piece({this.id_piece, required this.idMaison, required this.nom_piece});

  Map<String, dynamic> toMap() {
    return {
      'id_piece': id_piece,
      'id_maison': idMaison,
      'nom_piece':nom_piece,
    };
  }

  factory Piece.fromMap(Map<String, dynamic> map) {
    return Piece(
      id_piece: map['id_piece'],
      idMaison: map['id_maison'],
      nom_piece:map['nom_piece'],
    );
  }
}
