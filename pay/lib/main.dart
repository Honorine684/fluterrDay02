import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:pay/Home.dart';
import 'package:pay/Login.dart';
void main() => runApp(MaterialApp(
  home: Login(),
));

/*class ExampleApp extends StatelessWidget {
  const ExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SnakeNavigationBar Example ',
      home: SnakeNavigationBarExampleScreen(),
    );
  }
}*/

class SnakeNavigationBarExampleScreen extends StatefulWidget {
  const SnakeNavigationBarExampleScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SnakeNavigationBarExampleScreenState createState() =>
      _SnakeNavigationBarExampleScreenState();
}

class _SnakeNavigationBarExampleScreenState
    extends State<SnakeNavigationBarExampleScreen> {
  /*int appBarIndex = 0;
  final appBar = [
    
  ]; */ 
  final BorderRadius _borderRadius = const BorderRadius.only(
    topLeft: Radius.circular(25),
    topRight: Radius.circular(25),
  );

  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = const EdgeInsets.all(12);

  int _selectedItemPosition = 2;
  SnakeShape snakeShape = SnakeShape.circle;

  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  Color selectedColor = Colors.black;
  Color unselectedColor = Colors.blueGrey;

  Gradient selectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.amber]);
  Gradient unselectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.blueGrey]);

  Color? containerColor;
  List<Color> containerColors = [
    const Color(0xFFFDE1D7),
    const Color(0xFFE4EDF5),
    const Color(0xFFE7EEED),
    const Color(0xFFF4E4CE),
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
      resizeToAvoidBottomInset: true,
       extendBody: true,
            appBar: AppBar(
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
      body: AnimatedContainer(
        color: containerColor ?? containerColors[0],
        duration: const Duration(seconds: 1),
        child: PageView(
          onPageChanged: _onPageChanged,
          children: <Widget>[
            Home()
            /*PagerPageWidget(
              text: 'It comes in all shapes and sizes...',
              description:
                  'Change indicator and bottom bar shape at your will.',
              image: Image.asset('images/flutter2.png'),
            ),
            PagerPageWidget(
              text: '...not only the ones you see here',
              description:
                  'Combine different shapes for unique and personalized style!.',
              image: Image.asset('images/flutter3.png'),
            ),
            PagerPageWidget(
              text: 'And it\'s all open source!',
              description:
                  'Get the Flutter library on github.com/herodotdigital',
              image: Image.asset('images/flutter4.png'),
            ),*/
          ],
        ),
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        // height: 80,
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: bottomBarShape,
        padding: padding,

        ///configuration for SnakeNavigationBar.color
        snakeViewColor: selectedColor,
        selectedItemColor:
            snakeShape == SnakeShape.indicator ? selectedColor : null,
        unselectedItemColor: unselectedColor,

        ///configuration for SnakeNavigationBar.gradient
        // snakeViewGradient: selectedGradient,
        // selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
        // unselectedItemGradient: unselectedGradient,

        showUnselectedLabels: showUnselectedLabels,
        showSelectedLabels: showSelectedLabels,

        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() => _selectedItemPosition = index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: 'calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.podcasts), label: 'microphone'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), label: 'search')
        ],
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
    );
  }

  void _onPageChanged(int page) {
    containerColor = containerColors[page];
    switch (page) {
      case 0:
        setState(() {
          snakeBarStyle = SnakeBarBehaviour.floating;
          snakeShape = SnakeShape.circle;
          padding = const EdgeInsets.all(12);
          bottomBarShape =
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25));
          showSelectedLabels = false;
          showUnselectedLabels = false;
        });
        break;
      case 1:
        setState(() {
          snakeBarStyle = SnakeBarBehaviour.pinned;
          snakeShape = SnakeShape.circle;
          padding = EdgeInsets.zero;
          bottomBarShape = RoundedRectangleBorder(borderRadius: _borderRadius);
          showSelectedLabels = false;
          showUnselectedLabels = false;
        });
        break;

      case 2:
        setState(() {
          snakeBarStyle = SnakeBarBehaviour.pinned;
          snakeShape = SnakeShape.rectangle;
          padding = EdgeInsets.zero;
          bottomBarShape = BeveledRectangleBorder(borderRadius: _borderRadius);
          showSelectedLabels = true;
          showUnselectedLabels = true;
        });
        break;
      case 3:
        setState(() {
          snakeBarStyle = SnakeBarBehaviour.pinned;
          snakeShape = SnakeShape.indicator;
          padding = EdgeInsets.zero;
          bottomBarShape = null;
          showSelectedLabels = false;
          showUnselectedLabels = false;
        });
        break;
    }
  }
}

class PagerPageWidget extends StatelessWidget {
  final String? text;
  final String? description;
  final Image? image;
  final TextStyle titleStyle =
      const TextStyle(fontSize: 40, fontFamily: 'SourceSerifPro');
  final TextStyle subtitleStyle = const TextStyle(
    fontSize: 20,
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.w200,
  );

  const PagerPageWidget({
    Key? key,
    this.text,
    this.description,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: SafeArea(
        child: OrientationBuilder(builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _portraitWidget()
              : _horizontalWidget(context);
        }),
      ),
    );
  }

  Widget _portraitWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(text!, style: titleStyle),
            const SizedBox(height: 16),
            Text(description!, style: subtitleStyle),
          ],
        ),
        image!
      ],
    );
  }

  Widget _horizontalWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(text!, style: titleStyle),
              Text(description!, style: subtitleStyle),
            ],
          ),
        ),
        Expanded(child: image!)
      ],
    );
  }
}