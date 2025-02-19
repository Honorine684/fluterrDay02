import 'package:flutter/material.dart';

class Appbarcomponent extends StatefulWidget {
  const Appbarcomponent({super.key});

  @override
  State<Appbarcomponent> createState() {
  return AppbarcomponentState();

}
}
class AppbarcomponentState extends State<Appbarcomponent>{
 

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
    );
  }
  
}