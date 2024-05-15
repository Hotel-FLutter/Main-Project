import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sqlite_auth_app/page/profile.dart';
import 'package:flutter_sqlite_auth_app/page/search_page.dart';
import '../JSON/users.dart';
import 'detail_page.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  final Users? profile;
  const Home({super.key, this.profile});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  int currentIndex = 0;
  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      HomePage(profile: widget.profile,),
      HomePage(profile: widget.profile),
      const Search(),
      Profile(profile: widget.profile),
    ];
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          screens[currentIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(15),
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
  final Users? profile;
  const HomePage({super.key, this.profile});

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
            const Column(
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
            const Icon(Icons.notifications_active)
          ],
        )
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomNavBar(userName: 'John Doe'),
            const SizedBox(height: 10),
            RecommendedHotelsSection(profile:profile),
            const SizedBox(height: 20),
            const FacilitySection(),
            const SizedBox(height: 20),
            const ListMenu(),
            const SizedBox(height: 20),
            const DiscountSection(),
            const SizedBox(height: 100),
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
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(10)
      ),
      alignment: Alignment.center,
      child: Text('Welcome back, $userName!', style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600
        ), textAlign: TextAlign.center,),
    );
  }
}

class Recommended extends StatefulWidget { 
  final Users? profile;
  const Recommended({super.key, this.profile});

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
    return SizedBox(
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
            margin: const EdgeInsets.all(8),
            child: Column(
              children: [
                Image.asset(hotels[index]['gambar'], height: 160, width: 280, 
                fit: BoxFit.cover,),
                ListTile(
                  title: Text(hotels[index]["nama_hotel"], style: const TextStyle(
                    fontSize: 16
                  ),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 20,),
                          Text('${hotels[index]['kecamatan']}'),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 20,),
                          Text('Rating ${hotels[index]['rating']}'),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detail(hotel: hotels[index], profile: widget.profile,),
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
  final Users? profile;
  const RecommendedHotelsSection({super.key, this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recommended Hotels',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Recommended(profile: profile,)
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
      'icon': const Icon(Icons.pool_outlined)
    },
    {
      'nama':"Restoran",
      'icon': const Icon(Icons.restaurant)
    },
    {
      'nama':"Bar",
      'icon': const Icon(Icons.local_cafe_outlined)
    },
    {
      'nama':"Spa",
      'icon': const Icon(Icons.spa_outlined)
    },
    {
      'nama':"Meeting Room",
      'icon': const Icon(Icons.meeting_room_outlined)
    },
    {
      'nama':"Fitness Center",
      'icon': const Icon(Icons.fitness_center_outlined)
    },
    {
      'nama':"Gym",
      'icon': const Icon(Icons.sports_gymnastics_outlined)
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Facility',
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
              margin: const EdgeInsets.all(8),
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
  const DiscountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Discounts',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Special Offer!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Get 20% off on selected hotels. Book now!',
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Aksi saat tombol discount diklik
                },
                child: const Text('View Discounts'),
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
          margin: const EdgeInsets.only(bottom: 10),
          alignment: Alignment.topLeft,
          child: const Text('Featured Hotel',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
            ),
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
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