// creation de la classe users


class Users {
    final int? userId;
    final String? username;
    final String email;
    final String userPassword;
    final String? userAsset;
    final double solde = 1000;
    
   
    Users({
        this.userId,
        this.username = "",
        this.userAsset = "assets/images/avatar.png",
        required this.email,
        required this.userPassword,
        
        
    });

    factory Users.fromMap(Map<String, dynamic> json) => Users(
        userId: json["userId"],
        username: json["username"],
        email: json["email"],
        userPassword: json["userPassword"],
        //solde: json["solde"]

    );

    Map<String, dynamic> toMap() => {
        "userId": userId,
        "username": username,
        "email": email,
        "userPassword": userPassword,
    };
}
