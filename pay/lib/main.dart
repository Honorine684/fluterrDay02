import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:pay/Pages/Home.dart';
import 'package:pay/authentication/Login.dart';
import 'package:pay/Pages/Wallet.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(MaterialApp(
    home: GetStarted(),
  ));
}

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginSreen(),
    );
  }
}

class LoginSreen extends StatefulWidget {
  const LoginSreen({super.key});

  @override
  State<LoginSreen> createState() {
    return LoginSreenState();
  }
}

class LoginSreenState extends State<LoginSreen> {
  bool estCharger = true;
  @override
  void initState() {
    // pour verifier automatiquement au demarrage que l'user est connecter
    _isUserLogged();
    super.initState();
  }

  Future<void> _isUserLogged() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');

    await Future.delayed(const Duration(milliseconds: 300));

    if (userId != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const SnakeNavigationBarExampleScreen()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Login()));
    }
    if (mounted) {
      setState(() {
        estCharger = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            estCharger ? const CircularProgressIndicator() : const SizedBox(),
      ),
    );
  }
}

/*mounted verifie que le widget existe avant de mettre a jour son etat
  en mode si pendant que ma classe eesaie de verfier la connexion si l'user quitte la page il pourrait y avoir une erreur
  cette variable m'evite les erreurs au cas ou le chargement de la page ne finit pas et que y aretour

  */

class SnakeNavigationBarExampleScreen extends StatefulWidget {
  const SnakeNavigationBarExampleScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SnakeNavigationBarExampleScreenState createState() =>
      _SnakeNavigationBarExampleScreenState();
}

class _SnakeNavigationBarExampleScreenState
    extends State<SnakeNavigationBarExampleScreen> {
  int activeBottom = 0;
  final pages = [Home(), Wallet(), Wallet()];
  final BorderRadius _borderRadius = const BorderRadius.only(
    topLeft: Radius.circular(25),
    topRight: Radius.circular(25),
  );

  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = const EdgeInsets.all(12);

  SnakeShape snakeShape = SnakeShape.circle;

  bool showSelectedLabels = true;
  bool showUnselectedLabels = true;

  Color selectedColor = Colors.blue;
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

  @override
  Widget build(BuildContext context) {
    //deconnexion
    Future<void> logout() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('userId'); // nettoyer l'user
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Login()),
        (route) => false, // supprime les routes precedentes
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
     // extendBody: true,
      body: pages[activeBottom],
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: bottomBarShape,
        padding: padding,

        ///configuration for SnakeNavigationBar.color
        snakeViewColor: selectedColor.withOpacity(0.2),
        selectedItemColor: selectedColor,
        unselectedItemColor: unselectedColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,

        currentIndex: activeBottom,
        onTap: (index) {
          if (index == 3) {
            // Index de l'icône de déconnexion
            logout();
          } else {
            activeBottom = index;
            _onPageChanged(activeBottom);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Wallet'),
          BottomNavigationBarItem(
              icon: Icon(Icons.gif_outlined), label: 'Cadeau'),
          BottomNavigationBarItem(
              icon: Icon(Icons.logout_sharp), label: 'deconnexion')
        ],
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
    );
  }

  void _onPageChanged(int activeBottom) {
    containerColor = containerColors[activeBottom];
    switch (activeBottom) {
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
