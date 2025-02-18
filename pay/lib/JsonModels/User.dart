// creation de la classe users


class Users {
    final int? userId;
    final String? username;
    final String email;
    final String userPassword;
    
   // Users({this.username = "", required this.email, required this.userPassword});
    Users({
        this.userId,
        this.username = "",
        required this.email,
        required this.userPassword,
    });

    factory Users.fromMap(Map<String, dynamic> json) => Users(
        userId: json["userId"],
        username: json["username"],
        email: json["email"],
        userPassword: json["userPassword"],
    );

    Map<String, dynamic> toMap() => {
        "userId": userId,
        "username": username,
        "email": email,
        "userPassword": userPassword,
    };
}
