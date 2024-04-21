import 'package:flutter/material.dart';
import 'package:hotel_mobile/page/home_page.dart';

void main(){
  runApp(const Hotel());
}

class Hotel extends StatelessWidget {
  const Hotel({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      routes: {
        '/' : (context) => const Home(),
        '/reservasi' : (context) => const Home(),
        '/search' : (context) => const Home(),
        '/detail' : (context) => const Home(),
        
      },
    );
  }
}