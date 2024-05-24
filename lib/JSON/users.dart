
import 'dart:convert';

Users usersFromMap(String str) => Users.fromMap(json.decode(str));

String usersToMap(Users data) => json.encode(data.toMap());

class Users {
  final int? usrId;
  final String? fullName;
  final String? email;
  final String usrName;
  final String password;

  Users({
    this.usrId,
    this.fullName,
    this.email,
    required this.usrName,
    required this.password,
  });

static Users? _currentUser;

  static Users? get currentUser => _currentUser;

  // Method untuk mengatur pengguna yang sedang login
  static void setCurrentUser(Users user) {
    _currentUser = user;
  }

  // Method untuk memuat pengguna yang sedang login dari SQLite
  static void loadCurrentUser(Users user) {
    _currentUser = user;
  }

  // Method untuk menghapus pengguna yang sedang login
  static void logout() {
    _currentUser = null;
    
  }
  
  factory Users.fromMap(Map<String, dynamic> json) => Users(
    usrId: json["usrId"],
    fullName: json["fullName"],
    email: json["email"],
    usrName: json["usrName"],
    password: json["usrPassword"],
  );

  Map<String, dynamic> toMap() => {
    "usrId": usrId,
    "fullName": fullName,
    "email": email,
    "usrName": usrName,
    "usrPassword": password,
  };
}
