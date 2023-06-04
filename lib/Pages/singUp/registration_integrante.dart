import 'package:firebase_core/firebase_core.dart';
import 'package:ummaisjesus/shared/models/integrantes_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ummaisjesus/Pages/equipes/equipes_page.dart';

import 'package:ummaisjesus/shared/models/equipes_model.dart';

class RegistratiionIntegrante extends StatefulWidget {
  EquipesModel equip;

  RegistratiionIntegrante(this.equip, {super.key});

  @override
  State<RegistratiionIntegrante> createState() =>
      _RegistratiionIntegranteState();
}

class _RegistratiionIntegranteState extends State<RegistratiionIntegrante> {
  //firebase

  // our form key
  final _formKey = GlobalKey<FormState>();

  final equipeNameController = TextEditingController();
  final equipeIntegrantesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Uri _url = Uri.parse(
        'https://docs.google.com/spreadsheets/d/10SbUj4umAWNkAsRokhrrFYY8D_FeuFAgbWB8_wa4jds/edit#gid=0');
//equipe name
    final EquipNameField = TextFormField(
      autofocus: false,
      controller: equipeNameController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Please enter your integrante name");
        }
        if (!regex.hasMatch(value)) {
          return ("your name  minimun 3 charater");
        }
        return null;
      },
      onSaved: (value) {
        equipeNameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.group),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Nome  do novo  integrante",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final NomeDosIntegrantes = TextFormField(
      autofocus: false,
      controller: equipeIntegrantesController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("observação inicial vacia");
        }
        if (!regex.hasMatch(value)) {
          return ("minimun 3 charater");
        }

        return null;
      },
      onSaved: (value) {
        equipeIntegrantesController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.group),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Observação inicial",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
//second name

//SingUpButton
    final singUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          createEquipe2();
        },
        child: const Text(
          "Cadastrar Integrante",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
//SingUpButton
    final EquipButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => EquipePage()));
        },
        child: const Text(
          "Ver as Equipes",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return WillPopScope(
      onWillPop: () async {
        if (null == null) {
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Equipe: ${widget.equip.nome}"),
                      const SizedBox(
                        height: 25,
                      ),
                      EquipNameField,
                      const SizedBox(
                        height: 25,
                      ),
                      NomeDosIntegrantes,
                      const SizedBox(
                        height: 25,
                      ),
                      singUpButton,
                      const SizedBox(
                        height: 25,
                      ),
                      EquipButton,
                    ],
                  )),
            ),
          ),
        )),
      ),
    );
  }

  Future createEquipe2() async {
    if (_formKey.currentState!.validate()) {
      final docEquip = FirebaseFirestore.instance
          .collection('equipes')
          .doc("${widget.equip.id}");

      // if (widget.equip.integrantes != null) {
      //   widget.equip.integrantes?.add(Integrantes(
      //       nomeInt: equipeNameController.text,
      //       pontosInt: "0",
      //       obsInt: [equipeIntegrantesController.text],
      //       id: getCustomUniqueId()));
      // }

      final equipeModel2 = EquipesModel(
        id: docEquip.id,
        nome: widget.equip.nome,
        pontos: widget.equip.pontos,
        obs: widget.equip.obs,
        integrantes: widget.equip.integrantes,
      );

      final json = equipeModel2.toJson();

      await docEquip.update(equipeModel2.toJson());

      Fluttertoast.showToast(msg: "Account create succesfull");

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => EquipePage()),
          (route) => false);
    }
  }

  singUpEquipe(String nome) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    final equipeModel = EquipesModel(
        nome: nome,
        pontos: "50",
        id: getCustomUniqueId(),
        obs: ["novo trabalho"],
        integrantes: []);

    await firebaseFirestore
        .collection("equipes")
        .doc()
        .set(equipeModel.toMap());
    Fluttertoast.showToast(msg: "Account create succesfull");

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => EquipePage()),
        (route) => false);
  }

  String getCustomUniqueId() {
    const String pushChars =
        '-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz';
    int lastPushTime = 0;
    List lastRandChars = [];
    int now = DateTime.now().millisecondsSinceEpoch;
    bool duplicateTime = (now == lastPushTime);
    lastPushTime = now;
    List timeStampChars = List<String>.filled(8, '0');
    for (int i = 7; i >= 0; i--) {
      timeStampChars[i] = pushChars[now % 64];
      now = (now / 64).floor();
    }
    if (now != 0) {}
    String uniqueId = timeStampChars.join('');
    if (!duplicateTime) {
      for (int i = 0; i < 12; i++) {
        lastRandChars.add((Random().nextDouble() * 64).floor());
      }
    } else {
      int i = 0;
      for (int i = 11; i >= 0 && lastRandChars[i] == 63; i--) {
        lastRandChars[i] = 0;
      }
      lastRandChars[i]++;
    }
    for (int i = 0; i < 12; i++) {
      uniqueId += pushChars[lastRandChars[i]];
    }
    return uniqueId;
  }
}
