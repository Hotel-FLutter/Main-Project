import 'package:flutter/material.dart';
import 'package:flutter_sqlite_auth_app/JSON/users.dart';
import 'package:flutter_sqlite_auth_app/Views/auth.dart';
import 'package:flutter_sqlite_auth_app/page/detail_page.dart';
import 'package:flutter_sqlite_auth_app/page/home_page.dart';
import 'package:flutter_sqlite_auth_app/page/reserve_page.dart';
import 'package:flutter_sqlite_auth_app/page/search_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Hotel());
}

class Hotel extends StatelessWidget {
  const Hotel({super.key});

  bool _isLoggedIn() {
    return Users.currentUser != null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.light,
        ),
        primaryColor: Colors.white,
      ),
      routes: {
        '/': (context) {
          return _isLoggedIn() ? const Home() : const AuthScreen();
        },
        '/home': (context) => const Home(),
        '/search': (context) => const Search(),
        '/reserve': (context) => const Reserve(hotel: {}),
        '/detail': (context) => const Detail(hotel: {}),
      },
    );
  }
}