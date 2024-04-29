import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_mobile/page/detail_page.dart';
import 'package:hotel_mobile/page/search_page.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
        if (value == 0) Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
        if (value == 1) Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
        if (value == 2) Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Search(),
          ),
        );
        if (value == 3) Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'explore'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'profile'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
        ]
      ),
      appBar: AppBar(
        title: Text('Hotel Booking App'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            CustomNavBar(userName: 'John Doe'),
            SizedBox(height: 20),
            SizedBox(height: 20),
            RecommendedHotelsSection(),
            SizedBox(height: 20),
            DiscountSection(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class CustomNavBar extends StatelessWidget {
  final String userName;

  const CustomNavBar({required this.userName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      color: Color.fromARGB(255, 255, 38, 240),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Welcome, $userName!'), // Ucapan selamat datang
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Aksi saat tombol profil ditekan
            },
          ),
        ],
      ),
    );
  }
}

class Recommended extends StatefulWidget {
  const Recommended({super.key});

  @override
  State<Recommended> createState() => _RecommendedState();
}

class _RecommendedState extends State<Recommended> {
  List<dynamic> hotels = [];

  Future<void> loadHotelData() async {
    String hotelDataString = await rootBundle.loadString('data/hotel_data.json');
    setState(() {
      hotels = json.decode(hotelDataString);
    });
  }

  @override
  void initState() {
    super.initState();
    loadHotelData();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          return Container(
            width: 150,
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(hotels[index]["nama_hotel"]),
              subtitle: Text('Rating: ${hotels[index]["rating"]}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Detail(hotel: hotels[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class RecommendedHotelsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recommended Hotels',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Recommended()
      ],
    );
  }
}

class DiscountSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Discounts',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Special Offer!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Get 20% off on selected hotels. Book now!',
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Aksi saat tombol discount diklik
                },
                child: Text('View Discounts'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}