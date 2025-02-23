import 'package:flutter/material.dart';
import 'package:pay/Component/Navbar.dart';
import 'package:pay/JsonModels/User.dart';
import 'package:pay/SQLite/sqlite.dart';
import 'package:pay/authentication/Signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final db = PayDb();
  bool hasLoginError = false;
  //controller de texte
  final email = TextEditingController();
  final passWord = TextEditingController();
  bool showPassword = false;
  // nous devons creer une cle global pour notre form
  final formKey = GlobalKey<FormState>();
  // connexion
  login() async {
    print("Tentative de connexion avec: ${email.text}");
    var response =
        await db.login(Users(email: email.text, userPassword: passWord.text));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Réponse de la BD: ${response!['userId']}");
    await prefs.setInt('userId', response['userId']);

    print("Connexion réussie, navigation vers Home");
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const SnakeNavigationBarExampleScreen()));
    }

  @override
  Widget build(BuildContext context) {
    final largeurEcran = MediaQuery.of(context).size.width;
    final hauteurEcran = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          // je met tout dans un form pour pouvoir verifier si mes elements sont vides ou pas
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // images
                Image.asset(
                  "assets/images/login.png",
                  width: largeurEcran * 0.6,
                ),
                SizedBox(
                  height: hauteurEcran * 0.02,
                ),

                // email
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blue.shade100,
                  ),
                  child: TextFormField(
                    controller: email,

                    // pour verifier si le champ est bien rempli
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email est obligatoire";
                      }
                      if (!value.contains('@')) {
                        return "L'email doit contenir un @";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        border: InputBorder.none,
                        hintText: "Email"),
                  ),
                ),
                //password
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blue.shade100,
                  ),
                  child: TextFormField(
                    controller: passWord,
                    // pour verifier si le champ est bien rempli
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Mot de passe obligatoire";
                      }
                      return null;
                    },
                    obscureText: !showPassword,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () => setState(() {
                            showPassword = !showPassword;
                          }),
                          icon: Icon(showPassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                        )),
                  ),
                ),

                SizedBox(
                  height: hauteurEcran * 0.01,
                ),
                // bouton de connexion
                Container(
                  width: largeurEcran * 0.9,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue),
                  child: TextButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await login();
                      }
                    },
                    child: Text(
                      "Se connecter",
                      style: TextStyle(
                          fontSize: largeurEcran * 0.04, color: Colors.white),
                    ),
                  ),
                ),
                //bouton d'inscription

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Pas de compte?",
                      style: TextStyle(fontSize: largeurEcran * 0.03),
                    ),
                    TextButton(
                      child: Text(
                        "S'inscrire",
                        style: TextStyle(fontSize: largeurEcran * 0.03),
                      ),
                      onPressed: () => setState(() {
                        // naviguer vers la page d'inscription
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Signup()));
                      }),
                    )
                  ],
                ),
                hasLoginError
                    ? Text(
                        "Email ou mot de passe incorrecte",
                        style: TextStyle(color: Colors.red),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
