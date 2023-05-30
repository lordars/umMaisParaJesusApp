import 'package:flutter/material.dart';

import 'package:ummaisjesus/Pages/home/home_page.dart';

import '../../shared/models/equipes_model.dart';

class DescriptionTeam extends StatefulWidget {
  EquipesModel equip;
  DescriptionTeam(this.equip, {super.key});

  @override
  State<DescriptionTeam> createState() => _DescriptionTeamState();
}

class _DescriptionTeamState extends State<DescriptionTeam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Um mais para Jesus",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {}, icon: Icon(Icons.logout_rounded)) //IconButton
          //IconButton
        ], //<Widget>[]
        backgroundColor: Colors.greenAccent[400],
        elevation: 50.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (contex) => HomePage(widget.equip)));
          },
        ),
      ),
      body: widget.equip.obs!.length > 0
          ? ListView.builder(
              itemCount: widget.equip.obs!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                      '${widget.equip.obs != null ? widget.equip.obs![index] : "Sem mensão "}'),
                );
              },
            )
          : const Center(child: Text('No items')),
    );
  }
}
