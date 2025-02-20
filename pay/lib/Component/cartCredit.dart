import 'package:flutter/material.dart';
import 'package:u_credit_card/u_credit_card.dart';

class Cartcredit extends StatelessWidget {
  const Cartcredit({super.key});

  @override
  Widget build(BuildContext context) {
    return 
              CreditCardUi(
                  width: 300,
                  cardHolderFullName: 'John Doe',
                  cardNumber: '1234567812345678',
                  validFrom: '01/23',
                  validThru: '01/28',
                  topLeftColor: Colors.blue,
                  doesSupportNfc: true,
                  placeNfcIconAtTheEnd: true,
                  cardType: CardType.debit,
                  cardProviderLogo: FlutterLogo(),
                  cardProviderLogoPosition: CardProviderLogoPosition.right,
                  showBalance: true,
                  balance: 128.32434343,
                  autoHideBalance: true,
                  enableFlipping: true,
                  cvvNumber: '123',
                  
              
            );
  }

}