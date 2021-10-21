class Compra {
  final int? id;
  final String nome;
  final int quantidade;

  Compra({
    this.id,
    required this.nome,
    required this.quantidade
  });

  factory Compra.fromMap(Map map) {
    return Compra(
      id: map['id'], 
      nome: map['nome'], 
      quantidade: map['quantidade']
    );
  }

  Map toMap() {
    Map<String, dynamic> map = {
      'nome': nome,
      'quantidade': quantidade
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }
}