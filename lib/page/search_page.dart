import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../JSON/users.dart';
import 'detail_page.dart';

class Search extends StatefulWidget {
  final Users? profile;
  const Search({super.key, this.profile});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<dynamic> hotels = [];
  List<dynamic> foundHotels = [];

  Future<void> loadHotelData() async {
    String hotelDataString =
        await rootBundle.loadString('data/hotel_data.json');
    setState(() {
      hotels = json.decode(hotelDataString);
      foundHotels = List.from(hotels);
    });
  }

  @override
  void initState() {
    super.initState();
    loadHotelData();
  }

  void filter(String enteredKeyword) {
    List<dynamic> result = [];
    if (enteredKeyword.isEmpty) {
      result = List.from(hotels);
    } else {
      result = hotels
          .where((hotel) => hotel['nama_hotel'].contains(enteredKeyword))
          .toList();
    }
    setState(() {
      foundHotels = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Samarinda'),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => filter(value),
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: foundHotels.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Image.asset(foundHotels[index]['gambar'], height: 160, width: 400, 
                        fit: BoxFit.cover,),
                      ListTile(
                        title: Text(foundHotels[index]["nama_hotel"], style: const TextStyle(
                          fontWeight: FontWeight.bold
                        ),),
                        subtitle: Text('Rating: ${foundHotels[index]["rating"]}'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Detail(hotel: foundHotels[index], profile: widget.profile,),
                              ));
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
