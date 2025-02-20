import 'package:flutter/material.dart';
import 'package:pay/Pages/Home.dart';
//import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';

class Sendmoney extends StatefulWidget {
  const Sendmoney({super.key});

  @override
  State<Sendmoney> createState() {
    return SendmoneyState();
  }
}

final List<Map<String,String>> card = [
{
  "image":"assets/images/avatar.png",
  "texte":"ebl physical card"
},
{
  "image":"assets/images/avatar.png",
  "texte":"ebl physical card"
},
{
  "image":"assets/images/avatar.png",
  "texte":"ebl physical card"
},
{
  "image":"assets/images/avatar.png",
  "texte":"ebl physical card"
},
{
  "image":"assets/images/avatar.png",
  "texte":"ebl physical card"
},
{
  "image":"assets/images/avatar.png",
  "texte":"ebl physical card"
},
];

class SendmoneyState extends State<Sendmoney> {
  bool voirRecherche = false;
  final searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
 int indexSelectione = 0;


  @override
  Widget build(BuildContext context) {
    final largeurEcran = MediaQuery.of(context).size.width;
    final hauteurEcran = MediaQuery.of(context).size.height;
    bool? isChecked = true;
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 20,width: 20,),
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
                  fontSize: largeurEcran * 0.06, fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: hauteurEcran * 0.02,
            ),
            Row(
              children: [
                Text("Select card"),
              ],
            ),
            SizedBox(height:hauteurEcran*0.01,),
            SizedBox(
              height: 45,
              width: largeurEcran*0.88,
              child:
              ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: card.length,
              itemBuilder: (context, index) => 
                GestureDetector(  
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
                    
                    color:indexSelectione == index ? Colors.blue : Colors.grey.withOpacity(0.2),),
                
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(card[index]["image"]!, height: 15, width: 15,),
                        SizedBox(height: 8,),
                    Text(card[index]["texte"]!,style: TextStyle(fontSize: 13,color: indexSelectione == index ? Colors.white : Colors.black,),)],) ),), ) ),

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
                      height: 55,
                      width: 55,
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
            SizedBox(height: hauteurEcran*0.02,),
            // mont cart

            Container(
              height: hauteurEcran*0.28,
              width: largeurEcran*0.85,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Column(
                children: [
                  Text("\$35",style: TextStyle(fontSize: largeurEcran*0.095),),
                ],
              )
            ),
            SizedBox(height: hauteurEcran*0.1,),
            Row(
              children: [

                //Checkbox
                Checkbox(
                  value: isChecked,
                  activeColor: Colors.blue,
                  tristate: true, 
                  onChanged: (newBool)=>
                  setState(() {
                    //isChecked = true;
                    isChecked = newBool;
                  })
                  ),
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
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("Send money",style: TextStyle(fontSize: largeurEcran*0.055,color: Colors.white),),
                ),
              ),
              SizedBox(height: hauteurEcran*0.1,width: largeurEcran*0.1,)  
          ],
        ),
      ),
    );
  }
}
