import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ummaisjesus/shared/models/login_model.dart';
import 'package:ummaisjesus/shared/constants/preferences_keys.dart';

import '../../shared/constants/CustomColors.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({super.key});

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  String databaseJson = '';

  final TextEditingController _nameInputController = TextEditingController();
  final TextEditingController _emailInputController = TextEditingController();
  final TextEditingController _passwordInputController =
      TextEditingController();
  final TextEditingController _passwordConfirmInputController =
      TextEditingController();

  bool showPassword = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 60),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          CustomColors().getgradientMainColor(),
          CustomColors().getgradientSetColor()
        ],
      )),
      child: SingleChildScrollView(
          child: Column(
        children: [
          const Text(
            "Cadastro",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.only(bottom: 15)),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Digite um nome Maior";
                    }
                    return null;
                  },
                  controller: _nameInputController,
                  autofocus: true,
                  decoration: const InputDecoration(
                      labelText: "Nome completo",
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white,
                      )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white))),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 15)),
                TextFormField(
                  controller: _emailInputController,
                  autofocus: true,
                  decoration: const InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.white,
                      ),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white,
                      )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white))),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 15)),
                TextFormField(
                  controller: _passwordInputController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Senha",
                    labelStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.white,
                    ),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                    )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
                TextFormField(
                  controller: _passwordConfirmInputController,
                  obscureText: (showPassword == true) ? false : true,
                  decoration: const InputDecoration(
                      labelText: "Confirme sua senha",
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(
                        Icons.key_sharp,
                        color: Colors.white,
                      ),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white,
                      )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white))),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: showPassword,
                      onChanged: (bool? newValue) {
                        setState(() {
                          showPassword = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _doSingUp();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors().getActivePrimaryButtonColor(),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            child: const Text("Cadastrar"),
          ),
        ],
      )),
    )));
  }

  void _doSingUp() async {
    // if (_formKey.currentState!.validate()) {
    //   SingUpService()
    //       .sigUp(_emailInputController.text, _passwordInputController.text);
    // } else {
    //   print("invalidado");
    // }

    Uri url = Uri.https(
        "ummaisprajesusapp-default-rtdb.firebaseio.com", "/users.json");

    final response = await http.post(url,
        body: json.encode({
          'name': _nameInputController.text,
          'email': _emailInputController.text,
          'password': _passwordInputController.text,
          'keepOn': false,
        }));
  }

  void _saveUser(LoginModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(
      PreferencesKeys.activeUser,
      json.encode(user.toJson()),
    );
  }
}
