import 'dart:html';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ummaisjesus/Pages/equipes/description_team_page.dart';
import 'package:ummaisjesus/Pages/equipes/equipes_page.dart';
import 'package:ummaisjesus/Pages/equipes/team_description_page.dart';
import 'package:ummaisjesus/Pages/login/login_page.dart';

import 'package:ummaisjesus/shared/models/equipes_model.dart';
import 'package:ummaisjesus/shared/models/integrantes_model.dart';
import 'package:ummaisjesus/shared/models/user_model.dart';

class HomePage extends StatefulWidget {
  EquipesModel equip;
  HomePage(this.equip, {super.key});

  // const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int pontosTotales = int.parse(widget.equip.pontos);
  int valorIncemental = 0;

  User? user = FirebaseAuth.instance.currentUser;

  UserModel loggedInUser = UserModel();

  // EquipesModel equipedMaisUm = EquipesModel();

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  final descEditingController = TextEditingController();
  final pontsCrontrollers = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final descriptionQuest = TextFormField(
      autofocus: false,
      controller: descEditingController,
      // validator: (){},
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.question_answer),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Describe e nome porque dos pontos",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

//Misum button
    final maisUm = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
        onPressed: () {
          setState(() {
            valorIncemental++;
          });
        },
        child: const Text(
          "+",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
//Misum button
    final menosUm = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        onPressed: () {
          setState(() {
            valorIncemental--;
          });
        },
        child: const Text(
          "-",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
//Atividades +7
    final atividadesPont = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
        onPressed: () {
          setState(() {
            valorIncemental = 0;
            valorIncemental += 7;
          });
        },
        child: const Text(
          "Atividades",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
//Atividades negativo -15
    final atividadesPontNeg = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        onPressed: () {
          setState(() {
            valorIncemental = 0;
            valorIncemental -= 15;
          });
        },
        child: const Text(
          "Não participa",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
//desrespeito
    final desrespeito = Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(20),
      color: Colors.redAccent,
      child: MaterialButton(
        onPressed: () {
          setState(() {
            valorIncemental = 0;
            valorIncemental -= 2;
          });
        },
        child: const Text(
          "Desr.",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
//concurso festa disfraz
    final festa = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
        onPressed: () {
          setState(() {
            valorIncemental = 0;
            valorIncemental += 5;
          });
        },
        child: const Text(
          "Festa",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
//enigmas
    final enigmas = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
        onPressed: () {
          setState(() {
            valorIncemental = 0;
            valorIncemental += 5;
          });
        },
        child: const Text(
          "Enigmas",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
//Puntuar button
    final putPoint = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Colors.black,
      child: MaterialButton(
          onPressed: () {
            setState(() {
              setState(() {
                pontosTotales = valorIncemental + pontosTotales;
                UpdateEquipe(pontosTotales.toString(), widget.equip);
              });
            });
          },
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Pontuar ",
                ),
                WidgetSpan(
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )),
    );
//Puntuar button
    final Voltar = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Colors.black,
      child: MaterialButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (contex) => EquipePage()));
          },
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Voltar ",
                ),
                WidgetSpan(
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )),
    );
//Puntuar time
    final putPointTime = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Color.fromARGB(255, 155, 53, 22),
      child: MaterialButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (contex) => TeamPage(widget.equip)));
          },
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Ver o Time ",
                ),
                WidgetSpan(
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Observação --->",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.comment),
            tooltip: 'Comment Icon',
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (contex) => DescriptionTeam(widget.equip)));
            },
          ),
          const SizedBox(
            width: 30,
          ),

          IconButton(
              onPressed: () {
                logOut(context);
              },
              icon: Icon(Icons.logout_rounded)) //IconButton
          //IconButton
        ], //<Widget>[]
        backgroundColor: Colors.greenAccent[400],
        elevation: 50.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => EquipePage()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                      height: 50,
                      child: Image.asset(
                        "assets/LogoAcampaMaisUmPraJesus.png",
                        fit: BoxFit.contain,
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Equipe: ${widget.equip.nome}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text("Pontos totales: "),
                      Text(
                        pontosTotales.toString(),
                        style: TextStyle(
                          color: pontosTotales < 20
                              ? Colors.red
                              : const Color.fromARGB(255, 25, 167, 210),
                          fontSize: 72,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Acrecentarndo ou tirando pontos:"),
                      Text(
                        valorIncemental.toString(),
                        style: const TextStyle(
                          color: Color.fromARGB(255, 25, 167, 210),
                          fontSize: 72,
                        ),
                      ),
                    ],
                  ),
                  descriptionQuest,
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 150, child: maisUm),
                      SizedBox(width: 150, child: menosUm),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width: 150, child: atividadesPont),
                      SizedBox(width: 150, child: atividadesPontNeg),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      festa,
                      const SizedBox(
                        width: 10,
                      ),
                      enigmas,
                      const SizedBox(
                        width: 10,
                      ),
                      desrespeito
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: putPoint),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Voltar,
                  ),
                  // SizedBox(
                  //     width: MediaQuery.of(context).size.width,
                  //     child: putPointTime),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _showMyDialog();
                      },
                      child: Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Center(
                                  child: Text(
                                    "Apagar equipe",
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                              Icon(Icons.delete_forever)
                            ],
                          ),
                        ),
                      ))
                ]),
          ),
        ),
      ),
    );
  }

  Future<void> logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  postDetailsToFirestore() async {
//call our firestore
//calling mour user model
//sending these values

    //  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    //  User? user = _auth.currentUser;

    // EquipesModel equipesModel = EquipesModel();
    // writing all the values

    // equipesModel.inicialpoint = pontosTotales;
    // equipesModel.uid = equipedMaisUm!.uid;
    // equipesModel.nome = '';

    // await firebaseFirestore
    //     .collection("equipes")
    //     .doc(user!.uid)
    //     .set(equipesModel.toMap());
    // Fluttertoast.showToast(msg: "Account create succesfull");

    //  Navigator.pushAndRemoveUntil(context,
    //      MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  }

  UpdateEquipe(String pontos, EquipesModel equip) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    if (equip.obs != null) {
      equip.obs?.add(descEditingController.text);
    }
    print(equip.obs);
    final docUser = firebaseFirestore.collection("equipes").doc(equip.id);

    docUser.update({
      'nome': equip.nome.toString(),
      'pontos': pontos.toString(),
      'obs': equip.obs?.map((e) => e),
    });
    Fluttertoast.showToast(msg: "Account create succesfull");

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => EquipePage()),
        (route) => false);
  }

  Future<void> _delete(String productId) async {
    final CollectionReference _equipes =
        FirebaseFirestore.instance.collection('equipes');
    await _equipes.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => EquipePage()),
        (route) => false);
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Está por apagar o equipe!!'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Você quer apagar um equipe.'),
                Text('Você tem certesa?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('apagar o equipe'),
              onPressed: () {
                Navigator.of(context).pop();
                _delete(widget.equip.id.toString());
              },
            ),
          ],
        );
      },
    );
  }
}
