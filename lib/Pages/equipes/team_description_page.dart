import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummaisjesus/Pages/equipes/equipes_page.dart';
import 'package:ummaisjesus/Pages/home/home_page.dart';
import 'package:ummaisjesus/Pages/singUp/registration_equipe.dart';
import 'package:ummaisjesus/Pages/singUp/registration_integrante.dart';
import 'package:ummaisjesus/shared/models/integrantes_model.dart';

import '../../shared/models/equipes_model.dart';

class TeamPage extends StatefulWidget {
  EquipesModel equip;
  TeamPage(this.equip, {super.key});

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  deleteUser(id) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Um Mais Para Jesus: TeamPage")),
      // body: ListView.builder(
      //   itemBuilder: (context, index) => ListTile(
      //     leading: CircleAvatar(
      //         child: Text(widget.equip.integrantes![index].pontosInt != null
      //             ? widget.equip.integrantes![index].pontosInt
      //             : "")),
      //     title: Text("${widget.equip.integrantes?.map((e) => e.toMap())}"),
      //     subtitle: Text(
      //         "${widget.equip.integrantes![index].obsInt?.map((e) => e ?? 'empy')}"),
      //     onTap: () {
      //       //home
      //       // Navigator.of(context).pushReplacement(
      //       //     MaterialPageRoute(builder: (contex) => EquipePage()));
      //     },
      //   ),
      //   itemCount: widget.equip.integrantes?.length ?? 0,
      // ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.plus_one),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RegistratiionIntegrante(widget.equip)));
        },
      ),
    );
  }

  Widget buildEquipe(Integrantes equipe) => Column(
        children: [
          ListTile(
            leading: CircleAvatar(child: Text('${equipe?.pontosInt}')),
            title: Text("${equipe?.nomeInt ?? ""}"),
            subtitle: Text(
                "${equipe.obsInt != null ? equipe.obsInt?.map((e) => e) ?? [] : "sem integrantes"}"),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (contex) => EquipePage()));
            },
          ),
        ],
      );

  Stream<List<String>>? readIntegrantes() {
    // List<Integrantes>? integrante = widget.equip.integrantes;
  }
}
