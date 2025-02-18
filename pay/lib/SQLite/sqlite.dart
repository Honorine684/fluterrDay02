
import 'package:path/path.dart';
import 'package:pay/JsonModels/User.dart';

import 'package:sqflite/sqflite.dart';

class PayDb {
  final databaseName = 'payDb';
  String users = "CREATE TABLE Users(userId INTEGER PRIMARY KEY AUTOINCREMENT,username TEXT UNIQUE,email TEXT UNIQUE,userPassword TEXT)";

  Future<Database> _database() async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath,databaseName);
    return openDatabase(path,version: 1,onCreate: (db, version) async => 
      await db.execute(users)
    ,);
     

    
  }

  Future<int> createUser(Users user) async{
    final db = await _database();
    return await db.insert("Users", user.toMap(),conflictAlgorithm: ConflictAlgorithm.replace,);
  }
  // methode de connexion
  Future<bool> login(Users user) async{
    final Database db = await _database();
    var result = await db.rawQuery(
      "SELECT* FROM Users WHERE email = '${user.email}' AND userPassword = '${user.userPassword}'"
    );
    if(result.isNotEmpty){
      return true;
    }else{
      return false;
    }
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
}


