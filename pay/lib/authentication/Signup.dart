import 'package:flutter/material.dart';
import 'package:pay/JsonModels/User.dart';
import 'package:pay/authentication/Login.dart';
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
  // verification email 
  String? validateEmail(String? value) {
  const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  final regex = RegExp(pattern);
  if(value!.isNotEmpty && !regex.hasMatch(value)){
    return "Entrez un email valide";
  }else{
    return null;
  }
}
    // utilisation de l'inscription user
 
  signup()async{
    final db = PayDb();
    try{
     bool emailExits = await db.isEmailExists(email.text) ;
     if(emailExits){
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Cet email est déja utilisé"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        action: SnackBarAction(
        label: "Rééssayer",
        onPressed: () => email.clear(),
        ),
        )
      );
      return;
     }
     // logique de l'inscription 
     db.createUser(Users(username: username.text,email: email.text,userPassword: passWord.text))
     .whenComplete((){Navigator.push(context,MaterialPageRoute(builder: (context) =>const Login()));});
                                  
  }catch(e){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Erreur lors de l'inscription"),
        backgroundColor: Colors.red,
        ));
  }
  }
  
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
                  validator: validateEmail,
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
                    }else if((passWord.text).length < 6){
                      return "Le mot de passe doit contenir plus de 6 caractères";
                    }else if(!RegExp(r'[a-zA-Z]').hasMatch(passWord.text)){
                      return "Le mot de passe doit contenir des lettres";
                    }else if(!RegExp(r'\d').hasMatch(passWord.text)){
                      return "Le mot de passe doit contenir des nombres";
                    }else if((passWord.text).contains(' ')){
                      return "Le mot de passe ne peut contenir d'espace";
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
                      signup();            
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