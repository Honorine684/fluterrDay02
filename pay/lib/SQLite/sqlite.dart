
import 'package:path/path.dart';
import 'package:pay/JsonModels/User.dart';
import 'package:shared_preferences/shared_preferences.dart';



import 'package:sqflite/sqflite.dart';

class PayDb {
  final databaseName = 'payDb';
  String users = "CREATE TABLE Users(userId INTEGER PRIMARY KEY AUTOINCREMENT,username TEXT UNIQUE,email TEXT UNIQUE,userPassword TEXT)";
  
  
               
  

  Future<Database> _database() async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath,databaseName);
    return openDatabase(path, version: 1, onCreate: (db, version) async {
    // Création de la table Users
    await db.execute(users);
    
    
    
  });
}
  // methode d'inscription
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
// methode controler si email existe
Future<bool> isEmailExists(String email)async{
  final Database db = await _database();
  var result = await db.query("Users",where: "email = ?",whereArgs: [email]);
  return result.isNotEmpty;
}

    //deconnexion
Future<void> logout() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('userId'); // nettoyer l'user
      
}
  Future<List<Users>> listUser() async {
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
}





