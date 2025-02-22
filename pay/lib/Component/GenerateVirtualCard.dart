import 'dart:math';

import 'package:pay/JsonModels/CarteVirtuelle.dart';

class Generatevirtualcard {
    // Format du numéro de carte: 
  // - Commence par 4 (Visa)
  // - 16 chiffres au total

  String generateNumber(){

    // doit commencer par 4 pour le visa 
    List<int> numero = [4];

    // generer aleatoirement les 14 chiffres que doit avoir le numero 
    Random random = Random.secure(); // utilisation de secure pour des nombres sécurisés
    for(int i =0;i<15;i++){
      numero.add(random.nextInt(10));
    }

    // organiser les 14 chiffres par lot de 4
    return numero.join(' ').replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)} ').trim();
  }
    // Générer un CVV (3 chiffres) parce que le ccv doit toujouirs contenie trois chiffres
  String generateCVV() {
    Random random = Random.secure();
    return (random.nextInt(900) + 100).toString(); // Génère entre 100 et 999
  }

String generateDateExpiration() {
  final date = DateTime.now().add(Duration(days: 3));
  
  final jour = date.day.toString().padLeft(2, '0');    // "07"
  final mois = date.month.toString().padLeft(2, '0');  // "02"
  final annee = date.year.toString().substring(2);     // "24"
  
  return '$jour/$mois/$annee';  // "07/02/24"
}

Future<CarteVirtuelle> generateCard(int userId) async{
  
  // generer maintenant les infos de la carte en utilisant les methodes créés precedemment
  final String numCard = generateNumber();
  final String dateExpiration = generateDateExpiration();
  final String ccv = generateCVV();

  // crerr la carte virtuelle
   CarteVirtuelle card = CarteVirtuelle(
    userId: userId, 
    numCard: numCard, 
    cvvNumber: ccv,
    dateExpiration: dateExpiration
  );

  return card;
}

}
