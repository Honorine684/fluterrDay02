// creation de la classe contact


class Contact {
    final int? contactId;
    final int? userId;
    final String? contactName;
    final String contactEmail;
    final String? avatar;
    

    
   
    Contact({
        this.contactId,
        this.contactName = "",
        this.avatar = "",
        required this.userId,
        required this.contactEmail,    
    });

    factory Contact.fromMap(Map<String, dynamic> json) => Contact(
        contactId: json["contactId"],
        userId: json["userId"],
        contactName: json["contactName"],
        contactEmail: json["contactEmail"],
        avatar: json["avatar"],

    );

    Map<String, dynamic> toMap() => {
        "contactId": contactId,
        "userId": userId,
        "contactName": contactName,
        "contactEmail": contactEmail,
        "avatar": avatar,
        
    };
}
