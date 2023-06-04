class Integrantes {
  final String? id;
  final String nomeInt;
  final String pontosInt;
  final List<String>? obsInt;

  Integrantes(
      {required this.nomeInt, required this.pontosInt, this.id, this.obsInt});

  Map<String, dynamic> toMap() {
    return {
      'nome': nomeInt,
      'pontos': pontosInt,
      'id': id,
      'obs': obsInt,
    };
  }

  //Map<String, dynamic> toJson() =>
  //     {'id': id, 'nome': nomeInt, 'pontos': pontosInt, 'obs': obsInt};

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = nomeInt;
    data['pontos'] = pontosInt;
    data['obs'] = obsInt;
    data['id'] = id;

    return data;
  }

  static List<Integrantes> fromJson(Map<dynamic, dynamic> json) => [
        Integrantes(
          nomeInt: json['nome'],
          pontosInt: json['pontos'],
          id: json['id'],
          obsInt: List.from(json['obs']),
        )
      ];

//data from server
}
