import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../JSON/hotels.dart';
import '../JSON/users.dart';

class DatabaseHelper {
  final databaseName = "auth.db";

  //Tables

  String user = '''
   CREATE TABLE IF NOT EXISTS users (
   usrId INTEGER PRIMARY KEY AUTOINCREMENT,
   fullName TEXT,
   email TEXT,
   usrName TEXT UNIQUE,
   usrPassword TEXT
   )
   ''';

  String hotel = '''
   CREATE TABLE IF NOT EXISTS hotels (
   htlId INTEGER PRIMARY KEY AUTOINCREMENT,
   nameHotel TEXT,
   book INTEGER,
   checkInDate DATETIME,
   checkOutDate DATETIME,
   status TEXT
   )
   ''';

  //koneksi
  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    String path = join(databasePath, databaseName);
    // await deleteDatabase(path);
    return await openDatabase(path, version: 2, 
    onCreate: (Database db, int version) async {
      await db.execute(user);
      await db.execute(hotel);
    });
  }

  //Function methods
  
  //Hotel data
  Future<List<Hotels>> getAllHotels() async {
    final Database db = await initDB();
    var result = await db.rawQuery("SELECT * FROM hotels");
    return result.map((json) => Hotels.fromMap(json)).toList();
  }

  //Reserve
    Future<int> createHotel(Hotels htl) async {
    final Database db = await initDB();
    return db.insert("hotels", htl.toMap());
  }

  //Sign up
    Future<int> createUser(Users usr) async {
      final Database db = await initDB();
      return db.insert("users", usr.toMap());
  }

  //get Save Hotels
    Future<List<Hotels>> getSaveHotels() async {
    final Database db = await initDB();
    var result = await db.rawQuery("SELECT * FROM hotels WHERE status = 'save'");
    return result.map((json) => Hotels.fromMap(json)).toList();
  }

  //Authentication
  Future<bool> authenticate(Users usr) async {
    final Database db = await initDB();
    var result = await db.rawQuery(
        "select * from users where usrName = '${usr.usrName}' AND usrPassword = '${usr.password}' ");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  // User details
  Future<Users?> getUser(String usrName) async {
    final Database db = await initDB();
    var res =
        await db.query("users", where: "usrName = ?", whereArgs: [usrName]);
    return res.isNotEmpty ? Users.fromMap(res.first) : null;
  }
}
