import 'package:flutter/material.dart';
import 'package:pay/Home.dart';
//import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';

class Sendmoney extends StatefulWidget {
  const Sendmoney({super.key});

  @override
  State<Sendmoney> createState() {
    return SendmoneyState();
  }
}

class SendmoneyState extends State<Sendmoney> {
  bool voirRecherche = false;
  final searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  int tag = 1;
  List<String> tags = [];
  List<String> options = [
    "Physical abi card",
    "Physical abi card",
    "Physical abi card",
  ];
  @override
  Widget build(BuildContext context) {
    final largeurEcran = MediaQuery.of(context).size.width;
    final hauteurEcran = MediaQuery.of(context).size.height;
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(129, 255, 255, 255),
        elevation: 10,
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
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
              width: 20,
            ),
            Center(
              child: Divider(
              indent: largeurEcran*0.3,
              endIndent: largeurEcran*0.3,
              height: 50,
              thickness: 6,
              color: Colors.black,
            ),
            ),
            Center(
                child: Text(
              "Send money",
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  fontSize: largeurEcran * 0.06, fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: hauteurEcran * 0.02,
            ),
            Row(
              children: [
                Text("Select card"),
                /*Column(
                  children: [
                    ChipsChoice.single(
                        value: tag,
                        onChanged: (val) => setState(() {
                              val = tag;
                            }),
                        choiceItems:
                            C2Choice.listFrom(
                              source: options,
                              value: (i,v)=>i, 
                              label: (i,v)=>v,
                              disabled: (i,v)=> [0,2,5].contains(i)
                              ),
                        choiceActiveStyle: C2ChoiceStyle(
                          color: Colors.blue,
                          borderColor: Colors.blue,
                          borderRadius: BorderRadius.circular(5)
                          ),
                          choiceStyle: C2ChoiceStyle(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5)
                            ),
                        )
                  ],
                )*/
              ],
            ),
            SizedBox(height: hauteurEcran*0.02,),
            Row(
              children: [
                Text("Choose recipient",style: TextStyle(fontSize: largeurEcran*0.05,fontWeight: FontWeight.bold),)
              ],
            ),
            SizedBox(height: hauteurEcran*0.01,),
            TextField(
              keyboardType: TextInputType.text,
              
              cursorColor: Color(0xFF075E54),
              decoration: InputDecoration(
                hintText: 'Type name/card/phone number/email',
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 12),
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
            SizedBox(height: hauteurEcran*0.01,),
            SizedBox(
              height: hauteurEcran*0.1,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: activity.length,
                itemBuilder: (context,index)=>
                Row(
                  children: [
                    Container(
                      height: 65,
                      width: 65,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                         // borderRadius: BorderRadius.circular(10),
                         shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(activity[index]["image"]!),
                              fit: BoxFit.cover)),
                    ),
                  ],
                ),
              ),
            )
            ,SizedBox(height: hauteurEcran*0.02,),
            Row(
              children: [
                Text("Amount",style: TextStyle(fontSize: largeurEcran*0.06,fontWeight: FontWeight.bold),)
              ],
            ),
            // mont cart

            Row(
              children: [
                /*Checkbox(
                  value: value, 
                  onChanged: onChanged);*/
                Text("Agree with ideate's terms and conditions",style: TextStyle(fontSize: 12),)  
              ],
            ),
            // bouton send money
            Container(
                width: largeurEcran*0.9,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blue
                ),
                child: TextButton(
                  onPressed: () async {},
                  child: Text("Send money",style: TextStyle(fontSize: largeurEcran*0.055,color: Colors.white),),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
