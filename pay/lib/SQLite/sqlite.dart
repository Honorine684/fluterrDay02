import 'package:path/path.dart';
import 'package:pay/Component/GenerateVirtualCard.dart';
import 'package:pay/JsonModels/User.dart';
import 'package:sqflite/sqflite.dart';

class PayDb {
  final databaseName = 'payDb';
  String users =
      "CREATE TABLE Users(userId INTEGER PRIMARY KEY AUTOINCREMENT,username TEXT UNIQUE,email TEXT UNIQUE,userPassword TEXT)";
  String cartevirtuelle =
      "CREATE TABLE CarteVirtuelle(cardId INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER,numCard VARCHAR NOT NULL,cvvNumber VARCHAR NOT NULL,dateExpiration VARCHAR NOT NULL,FOREIGN KEY(userId) REFERENCES USERS(userId))";

  Future<Database> _database() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      // Création de la table Users
      await db.execute(users);
      // creation de la table carteVirtuelle
      await db.execute(cartevirtuelle);
    });
  }

  // methode d'inscription
  Future<int> createUser(Users user) async {
    final db = await _database();
    return await db.insert("Users", user.toMap());
  }

  // methode de connexion
  Future<Map<String, dynamic>?> login(Users user) async {
    final Database db = await _database();

    var result = await db.query(
      'Users',
      where: 'email = ? AND userPassword = ?',
      whereArgs: [user.email, user.userPassword],
    );
    print("Response $result");
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

// methode controler si email existe
  Future<bool> isEmailExists(String email) async {
    final Database db = await _database();
    var result =
        await db.query("Users", where: "email = ?", whereArgs: [email]);
    return result.isNotEmpty;
  }

  Future<List<Users>> listUser() async {
    // Get a reference to the database.
    final Database db = await _database();

    // Query the table for all the dogs.
    // ignore: non_constant_identifier_names
    final List<Map<String, Object?>> UsersMaps = await db.query('users');

    // Convert the list of each dog's fields into a list of `Dog` objects.
    return [
      for (final {
            'userId': userId as int,
            'username': username as String,
            'email': email as String,
            'userPassword': userPassword as String
          } in UsersMaps)
        Users(
            userId: userId,
            username: username,
            email: email,
            userPassword: userPassword),
    ];
  }

  // recuperer l'user coonecter

  Future<Users?> getUserConnected(int userId) async {
    final Database db = await _database();
    var result =
        await db.query("Users", where: 'userId = ?', whereArgs: [userId]);

    if (result.isNotEmpty) {
      return Users.fromMap(result.first);
    }
    return null;
  }

// ajout de la carteVirtuelle dans la bdd

  Future<void> createCard(Map<String, dynamic> carte) async {
    final db = await _database();
    await db.insert("CarteVirtuelle", carte);
  }

  Future<Map<String, dynamic>> cardForUser(int userId) async {
    Generatevirtualcard virtualCard =
        Generatevirtualcard(); //instancie generateVirtualCard
    final db = await _database();
    final List<Map<String, dynamic>> userResults =
        await db.query("Users", where: 'userId = ?', whereArgs: [userId]);
    if (userResults.isEmpty) {
      throw Exception("Utilisateur non trouvé");
    }
    var result = await virtualCard.generateCard(userId);
    await createCard(result);
    print("Nouvelle carte $result");
    return result;
  }

  Future<List<Map<String, Object?>>> getUserCards(int userId) async {
    final Database db = await _database();
    final cartes = await db.query(
      'CarteVirtuelle',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    print("Voici les cartes  : $cartes");
    return cartes;
  }
}
