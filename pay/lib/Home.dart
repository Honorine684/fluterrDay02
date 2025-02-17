import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  bool voirRecherche = false;
  final TextEditingController searchController = TextEditingController();
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
      appBar: AppBar(
        title: AnimatedCrossFade(
            firstChild: Row(
              
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset("assets/images/avatar.png",
                      width: largeurEcran * 0.13, height: hauteurEcran * 0.13),
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
              shape: BoxShape.circle,
              color: Colors.lightBlue.shade100
            ),
            width: largeurEcran*0.25,
            height: hauteurEcran*0.25,
            child: 
          IconButton(
            onPressed: () => setState(() {
              voirRecherche = !voirRecherche;
              if(!voirRecherche){
                searchController.clear();
              }
            }),   
         icon: Icon(voirRecherche ? Icons.close :Icons.search)))
         ],
      ),
      
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: largeurEcran*0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(right: 10,left: 10),
            child: 
            
            Container(
             // margin: EdgeInsets.only(right: 10,left: 10),
              width: largeurEcran*0.9,
              height: hauteurEcran*0.22,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("blablablabla",style: TextStyle(fontSize: largeurEcran*0.037,color: Colors.white),),
                      Text("blablablabla",style: TextStyle(fontSize: largeurEcran*0.037,color: Colors.white),)
                    ],
                  ),
                 

                  Text("630.21",style: TextStyle(fontSize: largeurEcran*0.1,fontWeight: FontWeight.bold,color: Colors.white),),
                  Text("blablabla",style: TextStyle(fontSize: largeurEcran*0.035,color: Colors.white),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("blablabla",style: TextStyle(fontSize: largeurEcran*0.035,color: Colors.white),),
                      Text("blablabla",style: TextStyle(fontSize: largeurEcran*0.035,color: Colors.white),)
                    ],
                  )

                ],
              ),
            )
        )],
        ),
      ),
    );
  }
}
