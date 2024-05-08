import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Views/auth.dart';

// import 'gen/colors.gen.dart';
// // import 'gen/fonts.gen.dart';
import 'page/home_screen.dart';

void main() {
  runApp(const Hotel());
}

class Hotel extends StatelessWidget {
  const Hotel({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      routes: {
        '/': (context) => const HomeScreen(),
        // '/reservasi': (context) => const HomeScreen(),
        // '/search': (context) => const HomeScreen(),
        // '/detail': (context) => const HomeScreen(),
      },
    );
  }
}
