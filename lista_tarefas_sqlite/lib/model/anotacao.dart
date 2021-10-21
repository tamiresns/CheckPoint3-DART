

class Anotacao {
   final int? id;
   final String titulo;
   final String descricao;
   final String data;

  Anotacao({ this.id, required this.titulo, required this.descricao, required this.data});

  factory Anotacao.fromMap(Map map) {
    return Anotacao(id: map['id'], titulo: map['titulo'], descricao: map['descricao'], data: map['data']);
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "titulo": titulo,
      "descricao": descricao,
      "data": data,
    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }
}
