class Maison {
  int? id;
  int id_imm;
  String numero;
  int nombreDePiece;

  Maison({this.id, required this.id_imm, required this.numero, required this.nombreDePiece});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_imm': id_imm,
      'numero': numero,
      'nombre_de_piece': nombreDePiece,
    };
  }

  factory Maison.fromMap(Map<String, dynamic> map) {
    return Maison(
      id: map['id'],
      id_imm: map['id_imm'],
      numero: map['numero'],
      nombreDePiece: map['nombre_de_piece'],
    );
  }
}
