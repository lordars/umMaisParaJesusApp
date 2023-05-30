import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:ummaisjesus/Pages/singUp/registration_equipe.dart';
import 'package:ummaisjesus/Pages/singUp/registration_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //form key
  final _formKey = GlobalKey<FormState>();
  //editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter Your Email");
        }
        // reg expression for email validator
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Pease enter a valid Email");
        }

        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Please enter your password");
        }
        if (!regex.hasMatch(value)) {
          return ("Please enter Password Valid minimon 6 charater");
        }
        return null;
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //login button
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          singIn(emailController.text, passwordController.text);
        },
        child: const Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
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
                    SizedBox(
                        height: 200,
                        child: Image.asset(
                          "assets/LogoAcampaMaisUmPraJesus.png",
                          fit: BoxFit.contain,
                        )),
                    const SizedBox(
                      height: 25,
                    ),
                    emailField,
                    const SizedBox(
                      height: 25,
                    ),
                    passwordField,
                    const SizedBox(
                      height: 30,
                    ),
                    loginButton,
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          ("Don´t have a accont?"),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegistratiionPage()));
                          },
                          child: const Text(
                            "SingUP",
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          ),
                        )
                      ],
                    )
                  ],
                )),
          ),
        ),
      )),
    );
  }

//login function
  void singIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        if (_auth != null) {
          await _auth
              .signInWithEmailAndPassword(email: email, password: password)
              .then((uid) => {
                    Fluttertoast.showToast(msg: "Login susccesfull"),
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (contex) => const RegistratiionEquipe())),
                  })
              .catchError((e) {
            Fluttertoast.showToast(msg: e!.message);
          });
        }
      } catch (err) {
        Fluttertoast.showToast(msg: err.toString());
      }
    }
  }
}
