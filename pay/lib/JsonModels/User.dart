// creation de la classe users


class Users {
    final int? userId;
    final String? username;
    final String email;
    final String userPassword;
    final double? solde;
    
   // Users({this.username = "", required this.email, required this.userPassword});
    Users({
        this.userId,
        this.username = "",
        required this.email,
        required this.userPassword,
        this.solde = 1000,
        
    });

    factory Users.fromMap(Map<String, dynamic> json) => Users(
        userId: json["userId"],
        username: json["username"],
        email: json["email"],
        userPassword: json["userPassword"],
        solde: json["solde"]

    );

    Map<String, dynamic> toMap() => {
        "userId": userId,
        "username": username,
        "email": email,
        "userPassword": userPassword,
    };
}
