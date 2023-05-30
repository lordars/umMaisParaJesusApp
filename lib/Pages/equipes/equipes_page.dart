import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummaisjesus/Pages/home/home_page.dart';
import 'package:ummaisjesus/Pages/singUp/registration_equipe.dart';

import '../../shared/models/equipes_model.dart';

class EquipePage extends StatefulWidget {
  EquipePage({super.key});

  @override
  State<EquipePage> createState() => _EquipePageState();
}

class _EquipePageState extends State<EquipePage> {
  deleteUser(id) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Um Mais Para Jesus TEAMs")),
      body: StreamBuilder<List<EquipesModel>>(
          stream: readEquipes(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final equipes = snapshot.data!;

              return ListView(
                children: equipes.map(buildEquipe).toList(),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.plus_one),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const RegistratiionEquipe()));
        },
      ),
    );
  }

  Widget buildEquipe(EquipesModel equipe) => Column(
        children: [
          ListTile(
            leading: CircleAvatar(child: Text('${equipe?.pontos}')),
            title: Text("${equipe?.nome}"),
            subtitle: Text(
                "${equipe.integrantes != null ? equipe.integrantes : "sem integrantes"}"),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (contex) => HomePage(equipe)));
            },
          ),
        ],
      );

  Stream<List<EquipesModel>> readEquipes() => FirebaseFirestore.instance
      .collection('equipes')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => EquipesModel.fromJson(doc.data()))
          .toList());

  Future<EquipesModel?> readOneEquipe() async {
    //get single ID
    final docEquipe =
        FirebaseFirestore.instance.collection('equipes').doc('uid');

    final snapshot = await docEquipe.get();

    if (snapshot.exists) {
      return EquipesModel.fromJson(snapshot.data()!);
    }
    return null;
  }
}
