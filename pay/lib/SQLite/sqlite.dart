
import 'package:path/path.dart';
import 'package:pay/JsonModels/Contact.dart';
import 'package:pay/JsonModels/User.dart';



import 'package:sqflite/sqflite.dart';

class PayDb {
  final databaseName = 'payDb';
  String users = "CREATE TABLE Users(userId INTEGER PRIMARY KEY AUTOINCREMENT,username TEXT UNIQUE,email TEXT UNIQUE,userPassword TEXT)";
  String contacts = "CREATE TABLE contacts (contactId INTEGER PRIMARY KEY AUTOINCREMENT,userId INTEGER,contactEmail VARCHAR NOT NULL,contactName VARCHAR,avatar VARCHAR,FOREIGN KEY (userId) REFERENCES users (userId))";
  
               
  

  Future<Database> _database() async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath,databaseName);
    return openDatabase(path, version: 1, onCreate: (db, version) async {
    // Création de la table Users
    await db.execute(users);
    
    // Création de la table Contacts
    await db.execute(contacts);
  });
}

  Future<int> createUser(Users user) async{
    final db = await _database();
    return await db.insert("Users", user.toMap(),conflictAlgorithm: ConflictAlgorithm.replace,);
  }
  // methode de connexion
  Future<Map<String, dynamic>?> login(Users user) async {
  final Database db = await _database();
  
  var result = await db.query(
    'Users',
    where: 'email = ? AND userPassword = ?',
    whereArgs: [user.email, user.userPassword],
  );
  
  if (result.isNotEmpty) {
    return result.first;
  }
  return null;
}

  Future<List<Users>> user() async {
    // Get a reference to the database.
    final Database db = await _database();

    // Query the table for all the dogs.
    // ignore: non_constant_identifier_names
    final List<Map<String, Object?>> UsersMaps = await db.query('users');

    // Convert the list of each dog's fields into a list of `Dog` objects.
    return [
      for (final {'userId': userId as int, 'username': username as String, 'email': email as String, 'userPassword': userPassword as String}
          in UsersMaps)
        Users(userId: userId, username: username,email: email,userPassword: userPassword),
    ];
  }

  // recuperer l'user coonecter
  

  Future<Users?> getUserConnected(int userId) async{
    final Database  db =  await _database();
    var result = await db.query("Users",
      where: 'userId = ?',
    whereArgs: [userId]);

    if(result.isNotEmpty){
      return Users.fromMap(result.first);
    }
    return null; 
  }

// ajouter contact pour un utilisateur donner

Future<int> createContact(Contact contact) async{
    final db = await _database();
    return await db.insert("Contact", contact.toMap(),conflictAlgorithm: ConflictAlgorithm.replace,);
  }
}

/*void addContact() async {
  int userId = 1; // L'ID de l'utilisateur auquel ce contact appartient
  
  // Crée un contact pour cet utilisateur
  Contact newContact = Contact(
    userId: userId, // Lier le contact à cet utilisateur
    contactName: 'John Doe',
    contactEmail: 'contact@exemple.com',
    avatar: 'https://exemple.com/avatar.png',
  );

  int result = await PayDb().createContact(newContact);
  print('Contact ajouté avec succès, ID : $result');
}*/


