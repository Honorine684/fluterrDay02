import 'package:flutter/material.dart';
import 'package:pay/Component/Navbar.dart';
import 'package:pay/authentication/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(MaterialApp(
    home: GetStarted(),
  ));
}

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginSreen(),
    );
  }
}

class LoginSreen extends StatefulWidget {
  const LoginSreen({super.key});

  @override
  State<LoginSreen> createState() {
    return LoginSreenState();
  }
}

class LoginSreenState extends State<LoginSreen> {
  bool estCharger = true;
  @override
  void initState() {
    // pour verifier automatiquement au demarrage que l'user est connecter
    _isUserLogged();
    super.initState();
  }

  Future<void> _isUserLogged() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');

    await Future.delayed(const Duration(milliseconds: 300));

    if (userId != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const SnakeNavigationBarExampleScreen()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Login()));
    }
    if (mounted) {
      setState(() {
        estCharger = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            estCharger ? const CircularProgressIndicator() : const SizedBox(),
      ),
    );
  }
}

/*mounted verifie que le widget existe avant de mettre a jour son etat
  en mode si pendant que ma classe eesaie de verfier la connexion si l'user quitte la page il pourrait y avoir une erreur
  cette variable m'evite les erreurs au cas ou le chargement de la page ne finit pas et que y aretour

  */


