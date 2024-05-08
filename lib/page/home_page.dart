import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sqlite_auth_app/page/search_page.dart';
import 'detail_page.dart';
import 'search_page.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  int currentIndex = 0;
  final screens =[
    HomePage(),
    HomePage(),
    Search(),
    Search(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          screens[currentIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BottomNavigationBar(
                  currentIndex: currentIndex,
                  onTap: (index)=> setState(() => currentIndex = index),
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.green,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.white70,
                  iconSize: 30,
                  selectedFontSize: 16,
                  unselectedFontSize: 12,
                  items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'explore'),
                    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'favorite'),
                    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'profile'),
                    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
                  ]
                ),
              ),
            ),
          ),
        ]
      ) 
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset('assets/Hotel.jpg', width: 40, height: 40, fit: BoxFit.cover,),
            ),
            Column(
              children: [
                Text('Current Location', style: TextStyle(
                  fontSize: 16
                ),),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 20, color: Colors.black45,),
                    Text('Samarinda, Kalimantan Timur', style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300
                    ),)
                  ],
                ),
              ],
            ),
            Icon(Icons.notifications_active)
          ],
        )
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomNavBar(userName: 'John Doe'),
            SizedBox(height: 10),
            RecommendedHotelsSection(),
            SizedBox(height: 20),
            FacilitySection(),
            SizedBox(height: 20),
            ListMenu(),
            SizedBox(height: 20),
            DiscountSection(),
            SizedBox(height: 100),
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
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.circular(10)
        ),
        alignment: Alignment.center,
        child: Text('Welcome back, $userName!', style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600
          ), textAlign: TextAlign.center,),
      )
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
      hotels = hotels.where((hotel) => hotel["rating"] >= 4.3).toList();
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
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black)
            ),
            // alignment: Alignment.center,
            width: 230,
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                Image.asset(hotels[index]['gambar'], height: 160, width: 280, 
                fit: BoxFit.cover,),
                ListTile(
                  title: Text(hotels[index]["nama_hotel"], style: TextStyle(
                    fontSize: 16
                  ),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 20,),
                          Text('${hotels[index]['kecamatan']}'),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, size: 20,),
                          Text('Rating ${hotels[index]['rating']}'),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detail(hotel: hotels[index]),
                      ),
                    );
                  },
                ),
              ],
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

class FacilitySection extends StatefulWidget {
  const FacilitySection({super.key});

  @override
  State<FacilitySection> createState() => _FacilitySectionState();
}

class _FacilitySectionState extends State<FacilitySection> {
  List<dynamic> facility =[
    {
      'nama':"Kolam Renang",
      'icon': Icon(Icons.pool_outlined)
    },
    {
      'nama':"Restoran",
      'icon': Icon(Icons.restaurant)
    },
    {
      'nama':"Bar",
      'icon': Icon(Icons.local_cafe_outlined)
    },
    {
      'nama':"Spa",
      'icon': Icon(Icons.spa_outlined)
    },
    {
      'nama':"Meeting Room",
      'icon': Icon(Icons.meeting_room_outlined)
    },
    {
      'nama':"Fitness Center",
      'icon': Icon(Icons.fitness_center_outlined)
    },
    {
      'nama':"Gym",
      'icon': Icon(Icons.sports_gymnastics_outlined)
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Facility',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
        ),
        Container(
          height: 100,
          alignment: Alignment.center,
          child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: facility.length,
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.center,
              width: 120,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
              ),
              margin: EdgeInsets.all(8),
              child: ListTile(
                title: facility[index]['icon'],
                subtitle: Text(facility[index]['nama'], textAlign: TextAlign.center,),
              ),
            );
          },
                ),
        ),
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

class ListMenu extends StatefulWidget {
  const ListMenu({super.key});

  @override
  State<ListMenu> createState() => _ListMenuState();
}

class _ListMenuState extends State<ListMenu> {
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
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          alignment: Alignment.topLeft,
          child: Text('Featured Hotel',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
            ),
        ),
        Container(
          height: 250,
          child: ListView.builder(
            itemCount: hotels.length  > 3 ? 3 : hotels.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.asset(hotels[index]['gambar'], width: 100, fit: BoxFit.cover,),
                title: Text(hotels[index]["nama_hotel"]),
                subtitle: Text('Rating: ${hotels[index]["rating"]}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Detail(hotel: hotels[index]),
                    )
                    );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}