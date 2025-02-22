import 'package:flutter/material.dart';
import 'package:pay/Component/cartCredit.dart';
import 'package:pay/Component/flChart.dart';
import 'package:pay/SQLite/sqlite.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() {
    return WalletState();
  }
}

final List<String> periode = ["Day", "Week", "Month", "Custom Range"];

class WalletState extends State<Wallet> {
  final db = PayDb();
  List userLoginCard = [
    {
      Cartcredit()
    }
  ];

  Future<void> _loadUserCards() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = prefs.getInt("userId");
    print("id $user");
    final cards = await db.getUserCards(user!);
    setState(() {
      userLoginCard.addAll(cards);
      print(cards.length);
    });
  }

// boite de dialogue pour poser question a l'user
  Future<void> _showCreateCardDialog() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = prefs.getInt("userId");
    return showDialog(
      context: context,
      builder: (BuildContext dialogueContext) {
        return AlertDialog(
          title: Text('Créer une carte virtuelle'),
          content: Text('Voulez-vous créer une nouvelle carte virtuelle ?'),
          actions: <Widget>[
            TextButton(
              child: Text('Non'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Oui'),
              
              onPressed: () async {
               
                Navigator.pop(context);
                try {
                  final newCard = await db.cardForUser(user!);
                  setState(() {
                    userLoginCard.add(newCard);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Carte créée avec succès !'),
                    backgroundColor: Colors.green,
                  ));
                } catch (e) {
                  print("Erreur:$e");
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Erreur lors de la création de la carte'),
                    backgroundColor: Colors.red,
                  ));
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadUserCards();
  }

  int indexSelectione = 0;
  @override
  Widget build(BuildContext context) {
    final largeurEcran = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(flex: 1),
                Text(
                  'Wallets',
                  style: TextStyle(
                      fontSize: largeurEcran * 0.075,
                      fontWeight: FontWeight.bold),
                  textDirection: TextDirection.ltr,
                ),
                const Spacer(flex: 1),
                Container(
                    margin: EdgeInsets.all(6),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.withOpacity(0.5),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: () {
                        _showCreateCardDialog();
                      },
                    )),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            // Affichage des cartes en horizontal scroll
            Container(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: userLoginCard.length + 1, // +1 pour la carte fixe
                itemBuilder: (context, index) {
                  if (index == 0) {
                    // Première carte fixe
                    return Container(
                      width: 150,
                      margin: EdgeInsets.only(right: 15),
                      child: Cartcredit(),
                    );
                  } else {
                    //print("voici la carte $index ")
                    // Cartes virtuelles de l'utilisateur
                    final card = userLoginCard[index];
                    return Container(
                      width: 150,
                      margin: EdgeInsets.only(right: 15),
                      child: Card(
                        color: Colors.blue,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Carte virtuelle',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 20),
                              Text(
                                card[index]["numCard"],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                              Spacer(),
                              Text(
                                'Expire: ${card[index]['dateExpiration']}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            
            const SizedBox(height: 20),

            // Total spending section
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Total spending",
                style: TextStyle(
                  fontSize: largeurEcran * 0.055,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: largeurEcran * 0.88,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.1)),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Espace les éléments uniformément
                children: List.generate(
                  periode.length,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        indexSelectione = index;
                      });
                    },
                    child: Text(
                      periode[index],
                      style: TextStyle(
                        fontSize: 12,
                        color: indexSelectione == index
                            ? Colors.blue // Couleur du texte si sélectionné
                            : Colors.black.withOpacity(0.5),
                        fontWeight: indexSelectione == index
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),
            // graphe
            Container(
              width: largeurEcran * 0.88,
              height: 250,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.1)),
                  borderRadius: BorderRadius.circular(5)),
              child: LineChartSample2(),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 100,
                  height: 80,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withOpacity(0.1)),
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Weekly spend",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "\$350.02",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
                ),
                Container(
                  width: 100,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black.withOpacity(0.1))),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Shopping",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "\$350.02",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
                ),
                Container(
                  width: 100,
                  height: 80,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withOpacity(0.1)),
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Others",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "\$350.02",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  width: largeurEcran * 0.88,
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withOpacity(0.1)),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Weekly income",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "\$215.125",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        label: const Text(
                          "See details",
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.withOpacity(0.2),
                          elevation: 0,
                        ),
                      ),
                      SizedBox(height: 80),
                    ],
                  ),
                )
              ],
            ),
          ]),
        ));
  }
}
