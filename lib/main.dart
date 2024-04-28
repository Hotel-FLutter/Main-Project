import 'package:flutter/material.dart';
import 'package:hotel_mobile/page/detail_page.dart';
import 'package:hotel_mobile/page/home_page.dart';

void main(){
  runApp(const Hotel());
}

class Hotel extends StatelessWidget {
  const Hotel({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.light
        ),
        primaryColor: Colors.white,
      ),
      routes: {
        '/' : (context) => const Home(),
        '/reservasi' : (context) => const Home(),
        '/search' : (context) => const Home(),
        '/detail' : (context) => const Detail(hotel: {},),
      },
    );
  }
}