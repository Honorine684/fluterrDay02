import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    final largeurEcran = MediaQuery.of(context).size.width;
    final hauteurEcran = MediaQuery.of(context).size.height;
    return Scaffold(
 
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
                borderRadius: BorderRadius.circular(5),
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
            ),
          
        ),
        SizedBox(height: hauteurEcran*0.02,),
        Text("Features",style: TextStyle(fontSize: largeurEcran*0.045,fontWeight: FontWeight.bold),),

        ],
        ),
      ),
    );
  }
}

       