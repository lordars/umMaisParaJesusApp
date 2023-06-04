import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummaisjesus/shared/models/integrantes_model.dart';

class EquipesModel {
  final String? id;
  final String nome;
  final String pontos;
  // final List<Integrantes>? integrantes;
  final List<String>? integrantes;
  final List<String>? obs;

  EquipesModel(
      {required this.nome,
      required this.pontos,
      this.id,
      this.integrantes,
      this.obs});

//data from server
  factory EquipesModel.fromMap(map) {
    return EquipesModel(
      nome: map['nome'],
      pontos: map['pontos'],
      id: map['id'],
      integrantes: map?['integrantes'] is Iterable
          ? List.from(map?['integrantes'])
          : null,
      obs: map?['obs'] is Iterable ? List.from(map?['obs']) : null,
    );
  }

  factory EquipesModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return EquipesModel(
      id: data?['id'],
      nome: data?['nome'],
      pontos: data?['pontos'],
      integrantes: data?['integrantes'] is Iterable
          ? List.from(data?['integrantes'])
          : null,
      obs: data?['obs'] is Iterable ? List.from(data?['obs']) : null,
    );
  }

//sending data to our server

  Map<String, dynamic> toMap() {
    return {
      if (nome != null) 'nome': nome,
      if (pontos != null) 'pontos': pontos,
      if (id != null) 'id': id,
      'integrantes': integrantes,
      'obs': obs,
    };
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'pontos': pontos,
        //  'integrantes': List.from(integrantes?.map((e) => e.toJson()) ?? {}),
        'obs': obs,
        'integrantes': integrantes
      };

  //obs: json?['obs'] is Iterable ? [] : null,

  static EquipesModel fromJson(Map<String, dynamic> json) => EquipesModel(
        nome: json['nome'],
        pontos: json['pontos'],
        id: json['id'],
        obs: List.from(json?['obs'] ?? "empy"),
        integrantes: List.from(json?['integrantes'] ?? "empy"),
        //  integrantes: List.from(Integrantes.fromJson(json["integrantes"][0]))

        //integrantes: List.from(json?['integrantes']),
      );
}
