import 'package:flutter/material.dart';
import 'package:pay/JsonModels/User.dart';
import 'package:pay/Login.dart';
import 'package:pay/SQLite/sqlite.dart';


class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() {
    return _SignupState();
  }

}

class _SignupState extends State<Signup>{
  //controller de texte
  final username = TextEditingController();
  final email = TextEditingController();
  final passWord = TextEditingController();
  final confirmPassword = TextEditingController();
  bool showPassword = false;
  // nous devons creer une cle global pour notre form
  final formKey = GlobalKey<FormState>();
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
              Image.asset("assets/images/login.png",width: largeurEcran*0.4,),
              SizedBox(height: hauteurEcran*0.02,),
              // username
              Container(
                 margin: EdgeInsets.all(8
                ),
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blue.shade100,
                ),
                child: TextFormField(
                 controller: username,
                  // pour verifier si le champ est bien rempli
                  validator: (value){
                    if(value!.isEmpty){
                      return "Username est obligatoire";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    border: InputBorder.none,
                    hintText: "Username"
                  ),
                ),
              ),
              // email
              Container(
                 margin: EdgeInsets.all(8
                ),
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
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
                    hintText: "Email"
                  ),
                ),
              ),
              //password
              Container(
                margin: EdgeInsets.all(8
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blue.shade100,
                ),
                child: TextFormField(
                  controller: passWord,
                  // pour verifier si le champ est bien rempli
                  validator: (value){
                    if(value!.isEmpty){
                      return "Mot de passe obligatoire";
                    }else if((passWord.text).length < 4){
                      return "Le mot de passe doit contenir plus de 4 caractères";
                    }
                    return null;
                  },
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    border: InputBorder.none,
                    hintText: "Password",
                    suffixIcon: IconButton(
                      onPressed: () => 
                      setState(() {
                        showPassword = !showPassword;
                      }),
                      icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
                    )
                  ),
                ),
              ),
              //confirmpassword
              Container(
                margin: EdgeInsets.all(8
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blue.shade100,
                ),
                child: TextFormField(
                  controller: confirmPassword,
                  // pour verifier si le champ est bien rempli
                  validator: (value){
                    if(value!.isEmpty){
                      return "Confirmer votre mot de passe";
                    }else if(passWord.text != confirmPassword.text){
                      return "Les mots de passe ne correspondent pas";
                    }
                    return null;
                  },
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    border: InputBorder.none,
                    hintText: "Confirm Password",
                    suffixIcon: IconButton(
                      onPressed: () => 
                      setState(() {
                        showPassword = !showPassword;
                      }),
                      icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
                    )
                  ),
                ),
              ),
              SizedBox(height: hauteurEcran*0.01,),
              // bouton d'inscription
              Container(
                width: largeurEcran*0.9,
                height: 60,
                
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue
                ),
                child: TextButton(
                  onPressed: () => setState(() {
                    if(formKey.currentState!.validate()){
                      //methode d'inscription
                      final db = PayDb();
                            
                               db.createUser(Users(
                                    username: username.text,
                                    email: email.text,
                                    userPassword: passWord.text))
                                .whenComplete(() {
                             
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Login()));
                            });
                  }
                  },),
                  child: Text("S'inscrire",style: TextStyle(fontSize: largeurEcran*0.04,color: Colors.white),),
                ),
              ),
              //bouton de connexion

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Vous êtes utilisateur?"),
                  TextButton(
                    child: Text("Se connecter"),
                    onPressed: () => setState(() {
                      // naviguer vers la page de connexion
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const Login()));
                    }),
                  )
                ],
              )
            ],
          ),
            ),
        ),
      ),
    );
  }
  
}