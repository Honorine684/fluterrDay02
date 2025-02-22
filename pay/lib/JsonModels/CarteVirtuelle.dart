// creation de la classe cartevirtuelle

class CarteVirtuelle {
    final int? cardId;
    final int userId;
    final String numCard;
    final String cvvNumber;
    final String dateExpiration;
    final double solde = 1000;
    
   
    CarteVirtuelle({
        this.cardId,
        required this.userId,
        required this.numCard,
        required this.cvvNumber,
        required this.dateExpiration,    
    });

    factory CarteVirtuelle.fromMap(Map<String, dynamic> json) => CarteVirtuelle(
        cardId: json["cardId"],
        userId: json["userId"],
        numCard: json["numCard"],
        cvvNumber: json["cvvNumber"],
        dateExpiration: json["dateExpiration"],
      

    );

    Map<String, dynamic> toMap() => {
        "cardId": cardId,
        "userId": userId,
        "numCard": numCard,
        "cvvNumber": cvvNumber,
        "dateExpiration": dateExpiration,
    };
}
