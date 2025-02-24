import 'package:flutter/material.dart';
import 'package:pay/Pages/Home.dart';
import 'package:pay/SQLite/sqlite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
//import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';

class Sendmoney extends StatefulWidget {
  const Sendmoney({super.key});

  @override
  State<Sendmoney> createState() {
    return SendmoneyState();
  }
}


class SendmoneyState extends State<Sendmoney> {
  // cargement carte User 
    final db = PayDb();
  int? id;
  List<Map<String, dynamic>> userLoginCard = [
    {
      "numCard": "1234567812345678",
      "cvvNumber": "250",
      "dateExpiration": "26/07/27"
    },
  ];

  Future<void> _loadUserCards() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final idUser = prefs.getInt("userId");
    if (idUser == null) {
      print("Erreur : l'ID utilisateur est null");
      return;
    }
    final cards = await db.getUserCards(idUser);
    setState(() {
      id = idUser;
      userLoginCard.addAll(cards);
    });

    print("Cartes $cards");
  }

  // Nouvelle liste pour stocker les utilisateurs
  List<Map<String, dynamic>> otherUsers = [];
   
  // Nouvelle méthode pour charger les autres utilisateurs
  Future<void> _loadUsers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final idUser = prefs.getInt("userId");
    try {
      if (idUser == null) return;
      
      final db = PayDb();
      var users = await db.getOtherUsers(idUser);

      setState(() {
        otherUsers = users; 
      });
      print("Autres utilisateurs chargés : $otherUsers");
    } catch (e) {
      print("Erreur lors du chargement des utilisateurs: $e");
    }
  }

    @override
  void initState() {
    super.initState();
     // Charger les utilisateurs immédiatement
  _loadUsers();
  // Puis charger les cartes
  _loadUserCards();
  }
  bool voirRecherche = false;
  final searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
  final _formKey = GlobalKey<FormState>();
  final recipientController = TextEditingController();
  final amountController = TextEditingController();
  int indexSelectione = 0;
  bool isChecked = false;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (!isChecked) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Veuillez accepter les conditions générales'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Récupération des valeurs
      final selectedCard = userLoginCard[indexSelectione];
      final recipient = recipientController.text;
      final amount = amountController.text;

      try {
        // Insérer dans la base de données ici
        // await db.insertTransaction(selectedCard, recipient, amount);
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Transaction enregistrée avec succès'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }  

  @override
  Widget build(BuildContext context) {
    final largeurEcran = MediaQuery.of(context).size.width;
    final hauteurEcran = MediaQuery.of(context).size.height;
   
    return Scaffold(
      //extendBodyBehindAppBar: true,
      /*appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        title: AnimatedCrossFade(
            firstChild: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset("assets/images/avatar.png",
                      width: largeurEcran * 0.13, height: hauteurEcran * 0.13),
                ),
                SizedBox(
                  width: 10,
                  height: 10,
                ),
                Text(
                  "Hello,Sacof!",
                  style: TextStyle(fontSize: largeurEcran * 0.04),
                ),
              ],
            ),
            secondChild: TextField(
              keyboardType: TextInputType.text,
              cursorColor: Color(0xFF075E54),
              decoration: InputDecoration(
                hintText: 'Rechercher...',
                hintStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(80),
                  borderSide: BorderSide(width: 0, style: BorderStyle.none),
                ),
                filled: true,
                contentPadding: EdgeInsets.all(8),
              ),
              controller: searchController,
            ),
            crossFadeState: voirRecherche
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 300)),
        actions: [
          Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.lightBlue.shade100),
              width: largeurEcran * 0.25,
              height: hauteurEcran * 0.25,
              child: IconButton(
                  onPressed: () => setState(() {
                        voirRecherche = !voirRecherche;
                        if (!voirRecherche) {
                          searchController.clear();
                        }
                      }),
                  icon: Icon(voirRecherche ? Icons.close : Icons.search)))
        ],
      ),*/
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20, width: 20),
              Center(
                child: Container(
                  width: 70,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Send money",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: largeurEcran * 0.06,
                    fontWeight: FontWeight.bold
                  ),
                )
              ),
              SizedBox(height: hauteurEcran * 0.02),
              Row(children: [Text("Select card")]),
              SizedBox(height: hauteurEcran * 0.01),
              if (userLoginCard.isEmpty)
                Center(
                  child: Text("Aucune carte disponible", 
                    style: TextStyle(color: Colors.grey)),
                )
              else
                SizedBox(
                  height: 45,
                  width: largeurEcran * 0.88,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: userLoginCard.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          indexSelectione = index;
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 170,
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: indexSelectione == index
                            ? Colors.blue
                            : Colors.grey.withOpacity(0.2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.credit_card,
                              size: 16,
                              color: indexSelectione == index
                                ? Colors.white
                                : Colors.black,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "****${userLoginCard[index]['numCard'].toString().substring(userLoginCard[index]['numCard'].toString().length - 4)}",
                              style: TextStyle(
                                fontSize: 13,
                                color: indexSelectione == index
                                  ? Colors.white
                                  : Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              SizedBox(height: hauteurEcran * 0.02),
              Row(
                children: [
                  Text(
                    "Choose recipient",
                    style: TextStyle(
                      fontSize: largeurEcran * 0.05,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
              SizedBox(height: hauteurEcran * 0.01),
              TextFormField(
                controller: recipientController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un destinataire';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Type name/card/phone number/email',
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 12
                  ),
                  suffixIcon: Icon(Icons.location_city),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(width: 0, style: BorderStyle.none),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(8),
                ),
              ),
             SizedBox(
                height: 100,
                child: otherUsers.isEmpty
      ? Center(
          child: Text("Aucun autre utilisateur disponible",
            style: TextStyle(color: Colors.grey)),
        )
      : ListView.builder(
          itemCount: otherUsers.length,
          itemBuilder: (context, index) {
            final user = otherUsers[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: user['userAsset'] != null
                  ? Image.asset(
                      user['userAsset'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                        Text(user['username'][0].toUpperCase()),
                    )
                  : Text(user['username'][0].toUpperCase()),
              ),
              title: Text(user['username'] ?? 'Sans nom'),
              subtitle: Text(user['email'] ?? 'Sans email'),
              onTap: () {
                setState(() {
                  recipientController.text = user['email'];
                });
              },
            );
          },
        ),
  

              ),

              SizedBox(height: hauteurEcran * 0.02),
              Row(
                children: [
                  Text(
                    "Amount",
                    style: TextStyle(
                      fontSize: largeurEcran * 0.06,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
              SizedBox(height: hauteurEcran * 0.02),
              Container(
                height: hauteurEcran * 0.20,
                width: largeurEcran * 0.85,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Column(
                  children: [
                    Text(
                      "\$35",
                      style: TextStyle(fontSize: largeurEcran * 0.095),
                    ),
                    Image.asset("assets/images/amount.png")
                  ],
                )
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un montant';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Veuillez entrer un montant valide';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Entrer le montant à envoyer',
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 12
                  ),
                  suffixIcon: Icon(Icons.money_off),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(width: 0, style: BorderStyle.none),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(8),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value ?? false;
                      });
                    },
                  ),
                  Text(
                    "Agree with ideate's terms and conditions",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              Container(
                width: largeurEcran * 0.9,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blue
                ),
                child: TextButton(
                  onPressed: _submitForm,
                  child: Text(
                    "Send money",
                    style: TextStyle(
                      fontSize: largeurEcran * 0.055,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: hauteurEcran * 0.1,
                width: largeurEcran * 0.1,
              )
      ]),
    )));
  }
}
