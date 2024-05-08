import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'detail_page.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State {
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
      body: Padding(
        padding: const EdgeInsets.all(15),
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
                  return ListTile(
                    title: Text(foundHotels[index]["nama_hotel"]),
                    subtitle: Text('Rating: ${foundHotels[index]["rating"]}'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Detail(hotel: foundHotels[index]),
                          ));
                    },
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
