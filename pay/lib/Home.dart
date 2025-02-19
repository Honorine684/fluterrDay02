import 'package:flutter/material.dart';
import 'package:pay/JsonModels/User.dart';
import 'package:pay/SQLite/sqlite.dart';
import 'package:pay/SendMoney.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() {
    return HomeState();
  }
}

final List<Map<String,String>> activity = [
  {
    "image":"assets/images/avatar.png",
    "texte1":"Miradie",
    "date1" : "22/04/02",
    "montant" : "+\$ 6555",
    "heure":"22h45"
  },
  {
    "image":"assets/images/login.png",
    "texte1":"Miradie",
    "date1" : "22/04/02",
    "montant" : "- \$ 6555",
    "heure":"22h45"
  },
  {
    "image":"assets/images/login.png",
    "texte1":"Miradie",
    "date1" : "22/04/02",
    "montant" : "\$ 6555",
    "heure":"22h45"
  },
  {
    "image":"assets/images/avatar.png",
    "texte1":"Miradie",
    "date1" : "22/04/02",
    "montant" : "+\$ 6555",
    "heure":"22h45"
  },
  {
    "image":"assets/images/avatar.png",
    "texte1":"Miradie",
    "date1" : "22/04/02",
    "montant" : "+\$ 6555",
    "heure":"22h45"
  },
  {
    "image":"assets/images/avatar.png",
    "texte1":"Miradie",
    "date1" : "22/04/02",
    "montant" : "+\$ 6555",
    "heure":"22h45"
  },
  {
    "image":"assets/images/avatar.png",
    "texte1":"Miradie",
    "date1" : "22/04/02",
    "montant" : "+\$ 6555",
    "heure":"22h45"
  },
  {
    "image":"assets/images/avatar.png",
    "texte1":"Miradie",
    "date1" : "22/04/02",
    "montant" : "+\$ 6555",
    "heure":"22h45"
  },
];

class HomeState extends State<Home> {

  Users? userData ;
  Future<Users?> getInfoUserConnecter() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final int? userId = prefs.getInt('userId');
  
  if (userId != null) {
    final db = PayDb();
    return await db.getUserConnected(userId);
  }
  
  return null;
}
Future<void> chargerInfoUser() async {
  final user = await  getInfoUserConnecter();
    setState(() {
      userData = user;});
}
String dropdownvalue = 'All'; 
  var items = [   
    'All', 
    'Receive',
    'Send',
  ];

  bool voirRecherche = false;
  final searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final largeurEcran = MediaQuery.of(context).size.width;
    final hauteurEcran = MediaQuery.of(context).size.height;
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: largeurEcran * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: hauteurEcran * 0.02,
            ),
            Padding(
              padding: EdgeInsets.only(right: 10, left: 10),
              child: Container(
                // margin: EdgeInsets.only(right: 10,left: 10),
                width: largeurEcran * 0.95,
                height: hauteurEcran * 0.20,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blue,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey
                          .withOpacity(0.2), //rend l'ombre semi transparente
                      spreadRadius: 3, //expansion de l'omnbre
                      blurRadius: 5, //controle le flou de l'ombre
                      offset: Offset(0, 3), //decale l'ombre de 3pixels
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 10,
                          height: 10,
                        ),
                        Text(
                          userData?.username ??"account",
                          style: TextStyle(
                              fontSize: largeurEcran * 0.037,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                          width: 109,
                        ),
                        Text(
                          userData?.username ??"account",
                          style: TextStyle(
                              fontSize: largeurEcran * 0.037,
                              color: Colors.white),
                        )
                      ],
                    ),
                    Text(
                      "${userData?.solde ?? '0.00'}",
                      style: TextStyle(
                          fontSize: largeurEcran * 0.1,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      "Total balance",
                      style: TextStyle(
                          fontSize: largeurEcran * 0.035, color: Colors.white),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 10,
                          width: 10,
                        ),
                        Text(
                          userData?.username ?? "account",
                          style: TextStyle(
                              fontSize: largeurEcran * 0.035,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                          width: 130,
                        ),
                        Text( "Acn124587"
                           ,
                          style: TextStyle(
                              fontSize: largeurEcran * 0.035,
                              color: Colors.white),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: hauteurEcran * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Features",
                  style: TextStyle(
                      fontSize: largeurEcran * 0.045,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "See more",
                  style: TextStyle(
                      fontSize: largeurEcran * 0.035,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: hauteurEcran * 0.01,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(6),
                  width: largeurEcran * 0.25,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  child: TextButton.icon(
                    label: Text(
                      "Send",
                      style: TextStyle(
                          fontSize: largeurEcran * 0.03, color: Colors.black),
                    ),
                    icon: Icon(
                      Icons.send,
                      color: Colors.black,
                    ),
                    onPressed: () => setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Sendmoney()));
                    }),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  width: largeurEcran * 0.28,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  child: TextButton.icon(
                    label: Text(
                      "Receive",
                      style: TextStyle(
                          fontSize: largeurEcran * 0.03, color: Colors.black),
                    ),
                    icon: Icon(
                      Icons.send,
                      color: Colors.black,
                    ),
                    onPressed: () => setState(() {
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> const Login()));
                    }),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  width: largeurEcran * 0.28,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  child: TextButton.icon(
                    label: Text(
                      "Rewards",
                      style: TextStyle(
                          fontSize: largeurEcran * 0.03, color: Colors.black),
                    ),
                    icon: Icon(
                      Icons.send,
                      color: Colors.black,
                    ),
                    onPressed: () => setState(() {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> const Login()));
                    }),
                  ),
                )
              ],
            ),
            SizedBox(
              height: hauteurEcran * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recently activity",
                  style: TextStyle(
                      fontSize: largeurEcran * 0.045,
                      fontWeight: FontWeight.bold),
                ),

                //dropdown
      
            DropdownButton<String>(
              
              // Initial Value
              value: dropdownvalue,
              hint: const Text("Filter By"),
              
              
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),    
              
              // Array list of items
              items: const [
                DropdownMenuItem(value: 'All',child: Text('All'),),
                DropdownMenuItem(value: "Recent",child: Text("Recent"),)
              ],
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) { 
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
          ],),
            

          
            SizedBox(height: largeurEcran * 0.02),
            SizedBox(
              height: hauteurEcran*0.4,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: activity.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      margin: EdgeInsets.only(right: 10, bottom: 10),
                      decoration: BoxDecoration(
                         // borderRadius: BorderRadius.circular(10),
                         shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(activity[index]["image"]!),
                              fit: BoxFit.cover)),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text(
                      activity[index]["texte1"]!,
                      style: TextStyle(fontSize: largeurEcran*0.04,fontWeight: FontWeight.bold),
                    ),
                    Text(
                      activity[index]["date1"]!,
                      style: TextStyle(fontSize: 12,color: Colors.black87),
                    ),
                    ],
                    ),
                    
                    Spacer(),
                    Column(
                      children: [
                        Text(activity[index]["montant"]!,
                        style: TextStyle(fontSize: largeurEcran*0.04,fontWeight: FontWeight.bold,color: Colors.blue)),
                        Text(
                      activity[index]["heure"]!,
                      style: TextStyle(fontSize: 12,color: Colors.black87),
                    ),
                      ],
                    )
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
